Talkingsdk_front::Application.routes.draw do

  devise_for :members,controllers: {:registrations => "registrations",sessions: "sessions"}

  namespace :platform do
    get 'index/index'
    get 'index/carousel'
    get 'deve_nav/carousel'
    get 'news/index'
    get 'help_center/index'
    get 'news/getNews'
  end

  namespace :member do
    get 'login/login'
    get 'login/create_capte'
    get 'login/check_login'
    get "notification/note"
    post 'member_info/create'
    get "member_info/edit"
    patch "member_info/updateBank"
    get "login/developerIndex"
    get "login/report7"
    post "member_info/updateInfo"
    get "changepswd/edit"
    patch "changepswd/update_password"
    get "financial/index"
    post "financial/newDeverTeam"
    get "financial/deverWithdraw"
    get "financial/amount"
    get "financial/automatic"
    get "income/index"
    get "month_review/index"
    get "app_add/index1"
    get "app_add/edit"
    patch "app_add/update"
    post "app_add/new"
    get "app_add/index2"
    get "app_add/index3"
    post "app_add/newAderTis"
    patch "app_manager/packageupload"
    get "app_manager/upload_success"
    get "app_manager/index"
    get "app_manager/deleteApp"
    get "app_manager/app_push"
    post "app_manager/newAderTis"
    get "app_manager/app_details"
    get "app_manager/set_status"
    get "app_manager/setStatus"
    get "app_manager/deleteAdvertising"
    get "takemoney/index"
    get "reward/index"
    get "notification/saveStatus"
    resources :integral_walls, constraints: { id: /[a-zA-Z.\/0-9_\-]+/ } do
      member do
        put :run
      end
    end
    post "integral_walls/uploadapk"
    get "appfilters/batchDestory"
    resources :appfilters, constraints: {id: /[a-zA-Z.\/0-9_\-]+/, tag: /[a-zA-Z.\/0-9_\-]+/}
    post "app_add/setAutoReflush"
    get "intelwal_statics/intelwalstatic"
    resources :intelwal_statics, constraints: { id: /[a-zA-Z.\/0-9_\-]+/ }
    get "app_statics/appstatic"
    get "app_statics/exportCvs"
    resources :app_statics, constraints: { id: /[a-zA-Z.\/0-9_\-]+/ }
  end


  namespace :advertiser do
    get "indexs/reportWeek"
    resources :indexs
    resources :ad_finances
    resources :ad_plans
    get "adv_statics/advstatic"
    get "adv_statics/exportCvs"
    resources :adv_statics
  end

  root to: "platform/index#index"
 # root to: "dashboard#show"
end
