class ToppagesController < ApplicationController
  before_action :genre_list 
  
  def index
    @posts = Post.order("RAND()").limit(1)
  end
end
