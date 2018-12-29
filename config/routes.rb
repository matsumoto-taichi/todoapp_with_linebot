Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/:id/edit' => 'tasks#edit', as: "task_edit"
  post 'tasks/:id/update' => 'tasks#update', as: "task_update"
  delete 'tasks/:id/delete' => 'tasks#delete', as: "task_delete"
  post 'lineBot' => 'line#bot'
end
