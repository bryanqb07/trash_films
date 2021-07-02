require 'railz_lite'
require_relative '../models/film'

 class FilmsController < RailzLite::ControllerBase
   def index
     @films = Film.all
   end

   def show
     @film = Film.find(params['id'])
   end

   def new
     @film = Film.new
   end

   def create
     @film = Film.new(params['film'])
     if @film.save
       flash[:notice] = 'Saved film successfully'
       redirect_to '/'
     else
       flash.now[:errors] = 'error creating film'
       render :new
     end
   end
 end
