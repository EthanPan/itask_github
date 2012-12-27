module ApplicationHelper

  # Generates a link to an attachment.
  # Options:
  # * :text - Link text (default to attachment filename)
  # * :download - Force download (default: false)
  def link_to_attachment(attachment, options={})
    text = options.delete(:text) || attachment.user_upload_file_name
    action = options.delete(:download) ? 'download' : 'show'
   
    link_to(h(text),
           {:controller => 'attachments', :action => action,
            :id => attachment, :filename => attachment.user_upload_file_name}.merge(options),
           )
  end
end
