module MarkdownAttachments
  class EmbedCodeService
    def initialize(markdown_attachment, view_context)
      @markdown_attachment = markdown_attachment
      @view_context = view_context
    end

    def embed_code
      code = "[#{filename}](#{url})"
      @markdown_attachment.image? ? "!#{code}" : code
    end

    def url
      "#{ENV['SITE_URL']}#{@view_context.url_for(@markdown_attachment.file)}"
    end

    private

    def github_url
      "#{ENV['SITE_URL']}/images/#{@markdown_attachment.token}-#{@markdown_attachment.file.filename}"
    end

    def filename
      @markdown_attachment.file.filename
    end
  end
end
