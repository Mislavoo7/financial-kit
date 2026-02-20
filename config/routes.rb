Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    devise_for :admins
    root "pages#index"
    resources :legal_pages, only: [:show], path: "legal-pages"

    post "/ai", to: "ai#generate"
    resources :names, only: [:index, :show]
    resources :credits, only: [:new, :create]

    namespace :user do
      root 'pages#index'
      resources :credits, only: [:edit, :update, :destroy]
      resource :accounts, only: [:edit, :update], path: :accounts, as: :accounts
      get 'destroy-me', to: 'accounts#destroy_me'
    end
    
    namespace :admin do
      root 'pages#index'
      resources :admins, except: [:show]
      resources :pages, only: [:edit, :update, :show] do
        collection do
          patch :sort
        end
        member do
          patch :visibility
        end
        resources :sections, except: [:index, :show] do
          collection do
            patch :sort
          end
          member do
            patch :visibility
          end
        end
      end
      resources :legal_pages, except: [:show], path: "legal-pages" do
        collection do
          patch :sort
        end
        member do
          patch :visibility
        end
      end
    end
  %w( 404 422 500 ).each do |code|
    get code, to: "errors#show", code: code
  end

    resources :pages, only: :show, path: ""
  end

end
