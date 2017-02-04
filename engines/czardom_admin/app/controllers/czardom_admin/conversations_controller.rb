module CzardomAdmin
  class ConversationsController < AdminController
    load_and_authorize_resource class: 'Mailboxer::Conversation'

    def index
      @conversations = @conversations.order('created_at desc').page(params[:page]).per(25)
      respond_with @conversations
    end

    def show
      respond_with @conversation
    end

  end
end
