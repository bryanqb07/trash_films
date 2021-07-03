require 'rack'
require 'railz_lite/controllers/static'
require 'railz_lite/controllers/show_exceptions'
require 'railz_lite/controllers/router'
require_relative '../controllers/films_controller'
require_relative '../controllers/reviews_controller'

class DummyController < RailzLite::ControllerBase
  def index
    redirect_to('/films')
  end
end

router = Router.new
router.draw do
  # add routes here
  get Regexp.new('^/$'), DummyController, :index
  get Regexp.new('^/films$'), FilmsController, :index
  get Regexp.new("^/films/(?<id>\\d+)$"), FilmsController, :show
  get Regexp.new("^/films/new$"), FilmsController, :new
  post Regexp.new("^/films$"), FilmsController, :create

  get Regexp.new("^/films/(?<film_id>\\d+)/reviews/new$"), ReviewsController, :new
  post Regexp.new("^/films/(?<film_id>\\d+)/reviews$"), ReviewsController, :create
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
