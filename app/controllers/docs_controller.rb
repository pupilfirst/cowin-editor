class DocsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @language = @category.language
    @docs = Doc.all.where(category: @category)
  end

  def show
    @doc = Doc.find(params[:id])
  end
end
