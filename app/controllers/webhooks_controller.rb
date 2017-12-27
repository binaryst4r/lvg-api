require 'services/email'

class WebhooksController < ApplicationController
  def sendgrid
    params = JSON.parse(request.body.read)
    response = Services::Email::Sendgrid.new(params).send_email
    respond_to do |format|
      format.json { render json:  response }
    end
  end
end
