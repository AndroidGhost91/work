module CzardomMessages
  class MessagesController < CzardomMessagesController

    def show
      message = conversation.messages.find(params[:id])
      render inline: message.body
    end

  end
end
