class SearchController < ApplicationController
  skip_forgery_protection

  def search
    @docs = Doc.search_full_text(params['search']).includes(category: :language)

    render json: { results: @docs.map { |s| format_doc(s) }, errors: nil }
  end

  private

  def format_doc(doc)
    {
      id: doc.id,
      title: doc.title,
      excerpt: doc.excerpt,
      url:
        "https://cowinindia.org/#{doc.category.language.slug}/#{doc.category.slug}/#{doc.slug}",
    }
  end
end
