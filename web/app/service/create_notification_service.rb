class CreateNotificationService
  include ServiceHelper
  include HTTParty

  APP_URI = 'https://dev.arsley.work'.freeze

  def initialize(notification_type:, resource:)
    @notification_type = notification_type
    @resource = resource
  end

  def call
    # テスト時に通知を送らないようにするためのもの
    # TODO: もっといい方法を探す
    return if Rails.env == 'test'

    HTTParty.post(
      'https://onesignal.com/api/v1/notifications',
      headers: headers,
      body: body,
      logger: logger,
      log_level: :debug,
      log_format: :curl
    )
  end

  private

  attr_reader :notification_type, :resource

  def headers
    {
      'Authorization' => "Basic #{ENV['ONESIGNAL_REST_API_KEY']}",
      'Content-Type'  => 'application/json'
    }
  end

  def notification_data
    @notification_data ||=
      case notification_type
      when :order_created
        # 'resource' は Order のインスタンスです
        {
          contents: {
            'en' => "Created Order##{resource.id} to Patient #{resource.patient.name}.",
            'ja' => "患者#{resource.patient.name}にオーダー##{resource.id}が作成されました。"
          },
          type: '新規オーダー作成',
          url:  APP_URI + "/orders/#{resource.id}"
        }
      when :order_updated
        # 'resource' は Order のインスタンスです
        {
          contents: {
            'en' => "#{resource.canceled? ? 'Canceled' : 'Re-reserved'} Order##{resource.id}.",
            'ja' => "オーダー##{resource.id}の状態を変更しました。"
          },
          type: 'オーダー情報更新',
          url:  APP_URI + "/orders/#{resource.id}"
        }
      when :inspection_added
        # 'resource' は Order のインスタンスです
        {
          contents: {
            'en' => "Added inspections to Order##{resource.id}.",
            'ja' => "オーダー##{resource.id}に検査が追加されました。"
          },
          type: '検査の追加',
          url:  APP_URI + "/orders/#{resource.id}"
        }
      when :inspection_updated
        # 'resource' は Inspection のインスタンスです
        {
          contents: {
            'en' => "Updated inspection of Order##{resource.order.id}.",
            'ja' => "オーダー##{resource.order.id}の検査が更新されました。"
          },
          type: '検査の更新',
          url:  APP_URI + "/orders/#{resource.order.id}"
        }
      else
        raise UndefinedNotificationTypeError
      end
  end

  def body
    {
      'app_id' => ENV['ONESIGNAL_APP_ID'],
      'included_segments' => ['All'],
      'url' => notification_data[:url],
      'data' => { 'type': notification_data[:type] },
      'contents' => notification_data[:contents]
    }.to_json
  end

  def logger
    ::Logger.new(Rails.root.join('log', 'push.log'))
  end

  class UndefinedNotificationTypeError < StandardError; end
end
