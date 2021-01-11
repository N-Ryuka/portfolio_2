class TagsController < ApplicationController
    before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.create(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      @tags = Tag.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
