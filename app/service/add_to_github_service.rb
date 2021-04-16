class AddToGithubService
  def initialize(language)
    @language = language
  end

  def execute
    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    repo = ENV['GITHUB_REPO']

    return unless @language.present?

    begin
      # Add node workflow
      client.create_contents(
        repo,
        "#{@language.name}.md",
        'Add a language',
        content,
      )
    rescue StandardError
      puts 'Error'
    end

    binding.pry
  end

  client.update_contents(
    repo,
    "#{@language.name}.md",
    'Add a language',
    a.sha,
    content,
  )

  def content
    'FOO'
  end
end
