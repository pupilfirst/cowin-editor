class DocsController < ApplicationController
  before_action :set_category, only: %w[index new create]

  def index
    @language = @category.language
    @docs = Doc.all.where(category: @category)
  end

  def show
    @doc = Doc.find(params[:id])
    @category = @doc.category
    @language = @category.language
  end

  def new
    @doc = Doc.new
  end

  def edit
    @doc = Doc.find(params[:id])
  end

  def create
    @doc = Doc.new(doc_params)

    if valid_slug
      if @doc.save
        flash[:success] = 'Doc created sucessfully!'
        redirect_to doc_path(@doc)
      else
        flash.now[:alert] = 'Unable to create!'
        render :new
      end
    else
      flash.now[:alert] = 'Add a unique slug'
      render :new
    end
  end

  def update
    @doc = Doc.find(params[:id])
    @doc.title = params[:doc][:title]
    @doc.content = params[:doc][:content]

    if @doc.save
      flash[:success] = 'Doc updated sucessfully!'
      redirect_to doc_path(@doc)
    else
      flash.now[:alert] = 'Unable to update!'
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def valid_slug
    Doc.where(slug: doc_params[:slug]).blank?
  end

  def doc_params
    params
      .require(:doc)
      .permit(:title, :content, :slug)
      .merge(slug: params[:doc][:slug].parameterize)
      .merge(category: @category)
  end
end
