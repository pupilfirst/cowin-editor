class CategoriesController < ApplicationController
  def index
    @language = Language.find(params[:language_id])
    @categories = Category.all.where(language: @language)
  end
end
