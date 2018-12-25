class CreateNotificationService
  include ServiceHelper
  include HTTParty

  # @contents [Hash] message that will show on notification's body
  #   it must contain 'english' message
  #   e.g. { 'en' => 'Hello!', 'ja' => 'こんにちは!' }
  # @type [string] type that show on onesignal
  def initialize(contents:, type:)
    @contents = contents
    @type     = type
  end

  def call
    # for run rspec
    # find better solution
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

  attr_reader :contents, :type

  def headers
    {
      'Authorization' => "Basic #{ENV['ONESIGNAL_REST_API_KEY']}",
      'Content-Type'  => 'application/json'
    }
  end

  # 'url' will be replaced
  # it must point location like Order#1
  def body
    {
      'app_id' => ENV['ONESIGNAL_APP_ID'],
      'included_segments' => ['All'],
      'url' => 'http://localhost:8080',
      'data' => { 'type': type },
      'contents' => contents
    }.to_json
  end

  def logger
    ::Logger.new(Rails.root.join('log', 'push.log'))
  end
end
