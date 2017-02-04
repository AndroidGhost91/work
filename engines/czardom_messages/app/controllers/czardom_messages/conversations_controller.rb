module CzardomMessages
  class ConversationsController < CzardomMessagesController

    respond_to :html

    def index
      @conversations = current_mailbox
      respond_with @conversations
    end

    def show
    end

    def new
      if params[:to].present?
        @default_recipient = User.find(params[:to])
      end
    end

    def create
      recipients = User.find(conversation_params(:recipients).split(','))

      conversation = current_user.send_message(recipients, *conversation_params(:body, :subject), false).conversation

      redirect_to conversation_path(conversation)
    end

    def reply
      message = current_user.reply_to_conversation(conversation, *message_params(:body, :subject), true, false)

      redirect_to conversation_path(conversation)
    end

    def trash
      conversation.move_to_trash(current_user)
      redirect_to :conversations
    end

    def untrash
      conversation.untrash(current_user)
      redirect_to :conversations
    end

    private

    def current_mailbox
      if params[:box].present? && ['inbox', 'sentbox', 'trash'].include?(params[:box])
        mailbox.send(params[:box])
      else
        mailbox.inbox
      end
    end
    helper_method :current_mailbox

    def conversation_params(*keys)
      fetch_params(:conversation, *keys)
    end

    def message_params(*keys)
      fetch_params(:message, *keys)
    end

    def fetch_params(key, *subkeys)
      params[key].instance_eval do
        case subkeys.size
        when 0 then self
        when 1 then self[subkeys.first]
        else subkeys.map{|k| self[k] }
        end
      end
    end


  end
end
