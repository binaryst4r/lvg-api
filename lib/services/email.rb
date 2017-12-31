include SendGrid

module Services
  module Email
    class Sendgrid
      attr_reader :email, :favorite_movie, :message

      def initialize(email, favorite_movie, message)
        @email = email
        @favorite_movie = favorite_movie
        @message = message
      end

      def send_email
        sendgrid_object = {
          "personalizations": [
            {
              "to": [
                {
                  "email": 'larryvgust@gmail.com'
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
              "value": "<strong>From:</strong> #{email}</br>
                        <strong>Favorite Movie:</strong> #{favorite_movie}<br/>
                        <p>#{message}</p>"
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
