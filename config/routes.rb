Rails.application.routes.draw do
  root "welcome#index"
  
  get "credit_line" => "credit_line#index"
  get "credit_line/new" => "credit_line#new"
  delete "credit_line/:id" => "credit_line#destroy"
  get "credit_line/:id" => "credit_line#show", :as => "show"
  post "credit_line" => "credit_line#create"
 
  get "payments" => "payments#index"
  get "payments/new" => "payments#new"
  delete "payments/:id" => "payments#destroy"
  get "payments/:id" => "payments#show"
  post "payments" => "payments#create"
  
end
