require 'line/bot'

class LineController < ApplicationController
  protect_from_forgery :except => [:bot]
  before_action :validate_signature

  def bot
    body = request.body.read
    events = client.parse_events_from(body)

    events.each {|event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text

          text = event['message']['text']
          task = Task.new(task: text)
          task.save!

          message = {
              type: 'text',
              text: "タスク：『#{text}』を登録しました！"
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }
    head 'ok'
  end


  private
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do
        'Bad Request'
      end
    end
  end

  def client
    @client ||= Line::Bot::Client.new {|config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end
end