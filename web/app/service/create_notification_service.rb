class CreateNotificationService
  include ServiceHelper

  def initialize(subscription_token:, title:, body:)
    @subscription_token = subscription_token
    @title = title
    @body  = body
  end

  def call
    Webpush.payload_send(
      message: message,
      endpoint: subscription['endpoint'],
      p256dh: subscription['keys']['p256dh'],
      auth: subscription['keys']['auth'],
      vapid: {
        subject: "mailto:blue20will@gmail.com",
        public_key: ENV['VAPID_PUBLIC_KEY'],
        private_key: ENV['VAPID_PRIVATE_KEY']
      },
      ssl_timeout:  5,
      open_timeout: 5,
      read_timeout: 5
    )
  end

  private

  attr_reader :subscription_token, :title, :body

  def subscription
    @subscription ||= JSON.parse(Base64.decode64(subscription_token))
  end

  def message
    @message ||= JSON.generate(title: title, body: body)
  end
end
