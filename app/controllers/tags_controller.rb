class TagsController < ActionController::Base
  
    def show
      @tag =  ActsAsTaggableOn::Tag.find(params[:id])
      @posts = Post.tagged_with(@tag.name)
    end
  end