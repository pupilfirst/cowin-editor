module Docs
  class CreateArticleService
    def initialize(doc)
      @doc = doc
    end

    def execute
      article_with_meta
    end

    private

    def article_with_meta
      <<-DOC
---
title: #{@doc.title}
excerpt: #{@doc.excerpt}
date: "#{@doc.created_at.to_time.iso8601}"
author:
  name: #{@doc.user.name}
---
#{@doc.content}
      DOC
    end
  end
end
