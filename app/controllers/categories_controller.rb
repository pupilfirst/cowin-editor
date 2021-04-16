class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_language, only: %w[index new create]

  def index
    @categories = Category.all.where(language: @language)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if valid_slug
      if @category.save
        flash[:success] = 'Category created sucessfully!'
        redirect_to category_docs_path(@category)
      else
        flash.now[:alert] = 'Unable to create!'
        render 'new'
      end
    else
      flash.now[:alert] = 'Add a unique slug'
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.title = params[:category][:title]
    if @category.save
      flash[:success] = 'Category updated sucessfully!'
      redirect_to category_docs_path(@category)
    else
      flash.now[:alert] = 'Unable to update!'
      render :edit
    end
  end

  private

  def set_language
    @language = Language.find(params[:language_id])
  end

  def valid_slug
    @language.categories.where(slug: category_params[:slug]).blank?
  end

  def category_params
    params
      .require(:category)
      .permit(:title, :slug)
      .merge(slug: params[:category][:slug].parameterize)
      .merge(language: @language)
  end
end
