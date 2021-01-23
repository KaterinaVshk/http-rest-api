Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    'employee/:id', controller: 'employees', action: 'show'
  post   'employee/:id', controller: 'employees', action: 'update'
  delete 'employee/:id', controller: 'employees', action: 'destroy'
  post   'employee', controller: 'employees', action: 'create'
  
  get    'company/:id', controller: 'companies', action: 'show'
  post   'company/:id', controller: 'companies', action: 'update'
  delete 'company/:id', controller: 'companies', action: 'destroy'
  post   'company', controller: 'companies', action: 'create'
  get   'company/:id/employees', controller: 'companies', action: 'get_list_employees'
end
 