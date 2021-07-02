require 'railz_lite'
require_relative '../models/film'
require_relative '../models/review'

 class ReviewsController < RailzLite::ControllerBase
   def new
     @film = Film.find(params['film_id'])
     @review = Review.new(film_id: @film.id)
   end

   def create
     @review = Review.new(params['review'].merge(film_id: params['film_id']))
     if @review.save
       flash[:notice] = 'Saved review successfully'
       redirect_to "/films/#{@review.film_id}"
     else
       flash.now[:errors] = 'error creating review'
       render :new
     end
   end
 end
