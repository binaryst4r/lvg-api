include SendGrid

module Services
  module Email
    class Sendgrid
      def initialize(params)
        @email = params[:email]
        @favorite_movie = params[:favorite_movie]
        @message = params[:message]
      end

      def send_email
        sendgrid_object = {
          "personalizations": [
            {
              "to": [
                {
                  "email": email
                }
              ],
              "subject": "Yo, someone contacted you"
            }
          ],
          "from": {
            "email": "contact@larrygust.io"
          },
          "content": [
            {
              "type": "text/html",
              "value": "<strong>And easy to do anywhere, even with Ruby</strong>"
            }
          ]
        }.to_json

        data = JSON.parse(sendgrid_object)
        puts data
        begin
          sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
          response = sg.client.mail._("send").post(request_body: data)
        rescue Exception => e
          puts e.message
        end

      end
    end
  end
end
