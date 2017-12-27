Rails.application.routes.draw do
  post 'webhooks/sendgrid', to: "webhooks#sendgrid"
end
