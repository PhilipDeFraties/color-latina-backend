class TwilioService
  def self.send_sms(to, body)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_number = ENV['TWILIO_PHONE_NUMBER']

    client = Twilio::REST::Client.new(account_sid, auth_token)

    client.messages.create(
      from: twilio_number,
      to: to,
      body: body
    )
  end
end