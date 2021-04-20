class MarkdownAttachmentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  # POST /markdown_attachments
  def create
    file =
      current_user.markdown_attachments.create(
        file: params[:markdown_attachment][:file],
        token: SecureRandom.urlsafe_base64,
      )

    if file
      embed_code =
        MarkdownAttachments::EmbedCodeService.new(file, view_context).embed_code

      # Github::CreateImageService.new(params[:markdown_attachment][:file], file).execute
      render json: { errors: [], markdownEmbedCode: embed_code }
    else
      render json: { errors: form.errors.full_messages }
    end
  end

  # GET /:id/:token
  def download
    markdown_attachment =
      authorize(
        MarkdownAttachment.where(token: params[:token]).find(params[:id]),
      )
    markdown_attachment.update!(last_accessed_at: Time.zone.now)
    redirect_to view_context.url_for(markdown_attachment.file)
  end
end
