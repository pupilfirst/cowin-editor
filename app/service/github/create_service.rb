module Github
  class CreateService
    def initialize(doc)
      @doc = doc
    end

    def execute
      repo = ENV['GITHUB_REPO']

      return unless @doc.present?

      begin
        client.create_contents(
          repo,
          path,
          "Create #{@doc.slug}.md",
          @doc.content,
        )
      rescue StandardError
        puts 'Error'
      end
    end

    private

    def path
      @path ||= "#{language.slug}/#{category.slug}/#{@doc.slug}.md"
    end

    def category
      @category ||= @doc.category
    end

    def language
      @language ||= category.language
    end

    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end
  end
end
