module CzardomMessages
  class CzardomMessagesController < ::ApplicationController
    before_action :authenticate_user!

    private

    def mailbox
      @mailbox ||= current_user.mailbox
    end
    helper_method :mailbox

    def conversation
      @conversation ||= mailbox.conversations.find(params[:conversation_id] || params[:id])
    end
    helper_method :conversation
  end
end
