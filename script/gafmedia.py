#!/usr/bin/env python

import os
import sys
import json
import time
import random
import hashlib
import urlparse
import requests
from bs4 import BeautifulSoup


UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36"


def login(name, password):
    print("[login]\thttp://www.gafmedia.com/converter/")
    params = {"action": "login"}
    data = {"login": name, "pass": password}
    headers = {"User-Agent": UserAgent, "Referer": "http://www.gafmedia.com/converter/"}
    r = requests.post("http://www.gafmedia.com/converter/", params=params, data=data, headers=headers, allow_redirects=False)
    return r.cookies


def get_project(cookies, project):
    url = "http://www.gafmedia.com/converter/"
    print("[project]\t%s" % project)
    params = {"action": "projects"}
    headers = {"User-Agent": UserAgent, "Referer": "http://www.gafmedia.com/converter/"}
    r = requests.get(url, params=params, headers=headers, cookies=cookies)
    soup = BeautifulSoup(r.text, "lxml")
    for section in soup.find_all("section", "projects-row"):
        for div in section.find_all("div", id=True):
            a = div.find("dt").find("a")
            if a.text == project:
                return urlparse.urljoin(url, a.attrs["href"])


def get_gaffile(cookies, url, name):
    group_id = urlparse.parse_qs(urlparse.urlparse(url).query)["group_id"][0]
    while True:
        print("[status]\t %s" % group_id)
        headers = {"User-Agent": UserAgent, "Referer": url, "X-Requested-With": "XMLHttpRequest"}
        r = requests.post(urlparse.urljoin(url, "./"), params={"action": "get_statuses", "group_id": group_id},
                data={"timestamp": int(time.time())}, headers=headers, cookies=cookies)
        d = json.loads(r.text)
        if d["status"] == "ok" and not d["data"]["pending_count"]:
            break
        time.sleep(3)
    print("[parse]\t %s" % name)
    headers = {"User-Agent": UserAgent, "Referer": url}
    r = requests.get(url, headers=headers, cookies=cookies)
    soup = BeautifulSoup(r.text, "lxml")
    for box in soup.find("div", id="animations").find_all("div", "box"):
        label = box.find("label")
        if label and label.text == name:
            return [a.attrs["href"] for a in box.find_all("a")]


def upload_swf(cookies, referer, filename, name):
    print("[upload]\t%s" % filename)
    headers = {"User-Agent": UserAgent, "Referer": referer}
    params = {"action": "upload", "mode": "animations"}
    file_id = hashlib.md5(filename + time.ctime() + str(random.random())).hexdigest()
    data = {"name": os.path.basename(filename), "file_id": file_id}
    files = {"file": (os.path.basename(filename), open(filename), "application/x-shockwave-flash")}
    url = urlparse.urljoin(referer, "./index.php")
    requests.post(url, params=params, headers=headers, cookies=cookies, data=data, files=files)
    print("[name]\t %s %s" % (name, file_id))
    requests.post(urlparse.urljoin(referer, "./"),
            params={"action": "animation", "do": "add_ajax"},
            data={"group_id": urlparse.parse_qs(urlparse.urlparse(referer).query)["group_id"][0],
                "items[0][file_id]": file_id,
                "items[0][name]": name},
            cookies=cookies)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("[usage] python gafmedia.py [project_name|project_id] [swf_filepath]")
        sys.exit(1)
    project = sys.argv[1]
    filename = sys.argv[2]
    name = os.path.basename(sys.argv[2]).rpartition(".")[0]
    cookies = login("nana_lucky@msn.com", "123456")
    url = project.isdigit() and ("http://www.gafmedia.com/converter/?action=animations&group_id=%s" % project) or get_project(cookies, project)
    upload_swf(cookies, url, filename, name)
    source, gafzip = get_gaffile(cookies, url, name)
    print("[source] %s" % source)
    print("[gafzip] %s" % gafzip)
