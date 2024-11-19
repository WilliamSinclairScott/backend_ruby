class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Cleanup on unsubscribe
  end

  def speak(data)
    message = Message.create!(user: data['user'], content: data['message'])
    ActionCable.server.broadcast("chat_channel", { user: message.user, message: message.content })
  end
end
