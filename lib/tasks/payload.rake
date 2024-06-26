require_relative '../nusa/payload'
require 'faraday'

namespace :payload do
  desc 'Generate JWT'
  task :send, [:service, :image, :url] do |_, args|
    secret = ENV['WEBHOOK_JWT_SECRET']
    abort 'WEBHOOK_JWT_SECRET not set' if secret.to_s.empty?
    coder = Nusa::Payload.new(secret: secret)
    jwt = coder.generate!(service: args.service, image: args.image)
    url = "#{args.url}/deploy/#{jwt}"
    response = Faraday::Connection.new.get(url) do |request|
      request.options.timeout = 300
    end
    pp response.body
  end
end
