Mortalidadinfantil::Application.routes.draw do
  match '/resources' => 'api#locations'
  root :to => "main#index"
end
