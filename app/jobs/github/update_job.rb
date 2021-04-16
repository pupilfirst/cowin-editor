module Github
  class UpdateJob < ApplicationJob
    queue_as :default

    def perform(doc)
      Github::UpdateService.new(doc).execute
    end
  end
end
