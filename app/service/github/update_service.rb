module Github
  class UpdateService
    def initialize(doc)
      @doc = doc
    end

    def execute
      return unless @doc.present?

      return unless file.present?

      begin
        client.update_contents(
          repo,
          path,
          "Update #{@doc.slug}.md",
          file.sha,
          @doc.content,
        )
      rescue StandardError
        puts 'Error'
      end
    end

    def file
      @file ||=
        begin
          client.contents(repo, path: path)
        rescue StandardError
          puts 'Error'
        end
    end

    def path
      @path ||= "docs/#{language.slug}/#{category.slug}/#{@doc.slug}.md"
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

    def repo
      @repo = ENV['GITHUB_REPO']
    end
  end
end
