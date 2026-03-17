Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    devise_for :admins
    root "pages#index"
    resources :legal_pages, only: [ :show ], path: "legal-pages"

    resources :names, only: [ :index, :show ]
    resources :credits, only: [ :new, :create ]
    resources :salary_calculators, only: [ :new, :create ], path: "salary-calculators"
    resources :author_fee_calculators, only: [ :new, :create ], path: "author-fee-calculators"
    resources :service_contract_calculators, only: [ :new, :create ], path: "service-contract-calculators"

    namespace :user do
      root "pages#index"
      resources :calculations, only: [ :index ]
      resources :credits, only: [ :edit, :update, :destroy ]
      resources :salary_calculators, only: [ :edit, :update, :destroy ], path: "salary-calculators"
      resources :author_fee_calculators, only: [ :edit, :update, :destroy ], path: "author-fee-calculators"
      resources :service_contract_calculators, only: [ :edit, :update, :destroy ], path: "service-contract-calculators"
      resource :accounts, only: [ :edit, :update ], path: :accounts, as: :accounts
      get "destroy-me", to: "accounts#destroy_me"
    end

    namespace :admin do
      root "pages#index"
      resources :admins, except: [ :show ]
      resources :seos, except: [ :show ]
      resources :users, only: [ :index, :destroy ]
      resources :credits, only: [ :index, :destroy ]
      resources :salary_calculators, only: [ :index, :destroy ], path: "salary-calculators"
      resources :author_fee_calculators, only: [ :index, :destroy ], path: "author-fee-calculators"
      resources :service_contract_calculators, only: [ :index, :destroy ], path: "service-contract-calculators"
      resources :city_tax_rates, except: [ :show ], path: "city-tax-rates"
      resources :pages, only: [ :edit, :update, :show ] do
        collection do
          patch :sort
        end
        member do
          patch :visibility
        end
        resources :sections, except: [ :index, :show ] do
          collection do
            patch :sort
          end
          member do
            patch :visibility
          end
        end
      end
      resources :legal_pages, except: [ :show ], path: "legal-pages" do
        collection do
          patch :sort
        end
        member do
          patch :visibility
        end
      end
    end
  %w[ 404 422 500 ].each do |code|
    get code, to: "errors#show", code: code
  end

    resources :pages, only: :show, path: ""
  end
end
