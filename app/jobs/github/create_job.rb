module Github
  class CreateJob < ApplicationJob
    queue_as :default

    def perform(doc)
      Github::CreateService.new(doc).execute
    end
  end
end
