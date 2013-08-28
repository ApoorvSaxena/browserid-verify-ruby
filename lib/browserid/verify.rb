require "uri"
require "net/http"
require 'net/https'
require "json"

module BrowserID
  module Verify

    class Verify

      def initialize(type, audience, url = 'https://verifier.login.persona.org/verify')
        # Instance variables
        @type = type
        @audience = audience
        @url = url
        @uri = URI.parse(@url)

        # make an agent and remember it
        @https = Net::HTTP.new(@uri.host, @uri.port)
        @https.use_ssl = true
      end

      def verify(assertion)
        # make a new request
        request = Net::HTTP::Post.new(@uri.path)
        request.set_form_data({"audience" => @audience, "assertion" => assertion})

        # send the request
        response = @https.request(request)

        # if we have a non-200 response
        if ! response.kind_of? Net::HTTPSuccess
          return {
            "status" => "failure",
            "reason" => "Something went wrong with the request",
            "body" => response.body
          }
        end

        # process the response
        data = JSON.parse(response.body) || nil
        if data.nil?
          # JSON parsing error
          return  {"status" => "failure", "reason" => "Received invalid JSON from the remote verifier"}
        end

        return data
      end

    end

    def verify_remotely(audience, assertion, url = 'https://verifier.login.persona.org/verify')
      verifier = Verify.new('remote', audience)
      return verifier.verify(assertion)
    end

  end
end
