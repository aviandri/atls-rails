class BlogsController < ApplicationController
  @@index = 0
  def index
  	@blogs = Blog.all
  end

  def show
  	@blog = Blog.find(params[:id])
  end
  
end
