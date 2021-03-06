# frozen_string_literal: true

class CreateNotificationService
  include HTTParty

  APP_URI = 'https://dev.arsley.work'.freeze

  def self.call(notification_type:, order:)
    new(notification_type, order).call
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

  def initialize(notification_type, order)
    @notification_type = notification_type
    @order = order
  end

  attr_reader :notification_type, :order

  def headers
    {
      'Authorization' => "Basic #{Rails.application.credentials.onesignal[:rest_api_key]}",
      'Content-Type'  => 'application/json'
    }
  end

  def body
    {
      'app_id'   => Rails.application.credentials.onesignal[:app_id],
      'url'      => APP_URI + "/orders/#{order.id}",
      'data'     => { 'type': notification_data[:type] },
      'contents' => notification_data[:contents],
      'included_segments' => ['All']
    }.to_json
  end

  def notification_data
    @notification_data ||=
      case notification_type
      when :order_created then notification_data_order_created
      when :order_updated then notification_data_order_updated
      when :exam_added    then notification_data_exam_added
      when :exam_updated  then notification_data_exam_updated
      else raise UndefinedNotificationTypeError
      end
  end

  def notification_data_order_created
    {
      contents: {
        'en' => "Created Order##{order.id} to Patient #{order.patient.name}.",
        'ja' => "患者#{order.patient.name}にオーダー##{order.id}が作成されました。"
      },
      type: '新規オーダー作成'
    }
  end

  def notification_data_order_updated
    {
      contents: {
        'en' => "#{order.canceled? ? 'Canceled' : 'Re-reserved'} Order##{order.id}.",
        'ja' => "オーダー##{order.id}の状態を変更しました。"
      },
      type: 'オーダー情報更新'
    }
  end

  def notification_data_exam_added
    {
      contents: {
        'en' => "Added exams to Order##{order.id}.",
        'ja' => "オーダー##{order.id}に検査が追加されました。"
      },
      type: '検査の追加'
    }
  end

  def notification_data_exam_updated
    {
      contents: {
        'en' => "Updated exam of Order##{order.id}.",
        'ja' => "オーダー##{order.id}の検査が更新されました。"
      },
      type: '検査の更新'
    }
  end

  def logger
    ::Logger.new(Rails.root.join('log', 'push.log'))
  end

  class UndefinedNotificationTypeError < StandardError; end
end
