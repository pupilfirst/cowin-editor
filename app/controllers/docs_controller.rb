class DocsController < ApplicationController
  before_action :authenticate_user!
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
        Github::CreateJob.perform_later(@doc)
        render json: { id: @doc.id.to_s, errors: nil }
      else
        render json: { error: 'Unable to create!' }
      end
    else
      render json: { error: 'Add a unique filename' }
    end
  end

  def update
    @doc = Doc.find(params[:id])
    @doc.title = params[:doc][:title]
    @doc.excerpt = params[:doc][:excerpt]
    @doc.content = params[:doc][:content]

    if @doc.save
      Github::UpdateJob.perform_later(@doc)
      render json: { id: @doc.id.to_s, errors: nil }
    else
      render json: { error: 'Unable to update!' }
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def valid_slug
    @category.docs.where(slug: doc_params[:slug]).blank?
  end

  def doc_params
    params
      .require(:doc)
      .permit(:title, :content, :slug, :excerpt)
      .merge(slug: params[:doc][:slug].parameterize)
      .merge(category: @category)
      .merge(user: current_user)
  end
end
