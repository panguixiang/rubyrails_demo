require 'rubygems'
require 'rethinkdb'
include RethinkDB::Shortcuts
r.connect(:host => '10.17.104.56', :port => 28015).repl
row = r.db('hxsg').table('data').filter({:uid=>"1010384344"}).run.first

items = row["item"]

puts "items:#{items}"
