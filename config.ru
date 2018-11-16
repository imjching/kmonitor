require ::File.expand_path("../config/environment",  __FILE__)

set :app_file, __FILE__

configure do
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

run Sinatra::Application
