class ToppagesController < ApplicationController
  def index
    @posts = Post.order("RAND()").limit(1)
  end
end
