require 'services/email'

class WebhooksController < ApplicationController
  def sendgrid
    params = JSON.parse(request.body.read)

    email = params["email"]
    favorite_movie = params["favorite_movie"]
    message = params["message"]

    response = Services::Email::Sendgrid.new(email, favorite_movie, message).send_email
    respond_to do |format|
      format.json { render json:  response }
    end
  end
end
