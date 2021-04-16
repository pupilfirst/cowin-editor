class LanguagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @languages = Language.all
  end

  def new
    @language = Language.new
  end

  def edit
    @language = Language.find(params[:id])
  end

  def create
    @language = Language.new(language_params)

    if valid_slug
      if @language.save
        flash[:success] = 'Language created sucessfully!'
        redirect_to language_categories_path(@language)
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
    @language = Language.find(params[:id])
    @language.name = params[:language][:name]
    if @language.save
      flash[:success] = 'Language updated sucessfully!'
      redirect_to language_categories_path(@language)
    else
      flash.now[:alert] = 'Unable to update!'
      render :edit
    end
  end

  private

  def valid_slug
    Language.where(slug: language_params[:slug]).blank?
  end

  def language_params
    params
      .require(:language)
      .permit(:name, :slug)
      .merge(slug: params[:language][:slug].parameterize)
  end
end
