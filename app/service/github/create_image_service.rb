module Github
  class CreateImageService
    def initialize(file, markdown_attachment)
      @markdown_attachment = markdown_attachment
      @file = file
    end

    def execute
      repo = ENV['GITHUB_REPO']

      return unless @markdown_attachment.present?

      begin
        client.create_contents(repo, path, 'Add Image', file: @file.path)
      rescue StandardError
        puts 'Error'
      end
    end

    private

    def path
      @path ||=
        "images/#{@markdown_attachment.token}-#{@markdown_attachment.file.filename}"
    end

    def client
      @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end
  end
end
