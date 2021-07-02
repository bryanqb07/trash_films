require 'rack'
require 'railz_lite/controllers/static'
require 'railz_lite/controllers/show_exceptions'
require 'railz_lite/controllers/router'
require 'railz_lite'

class Film < RailzLite::SQLObject
  finalize!
end

# example controller config
 class WelcomeController < RailzLite::ControllerBase
   def index; end
 end

 class FilmsController < RailzLite::ControllerBase
   def index
     @films = Film.all
   end
 end

router = Router.new
router.draw do
  # add routes here
  get Regexp.new('^/$'), WelcomeController, :index
  get Regexp.new('^/films$'), FilmsController, :index
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ShowExceptions # generates helpful error messages
  use Static # serves static assets from /public
  run app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
)
