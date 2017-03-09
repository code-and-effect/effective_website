module Letsencrypt
  class Middleware
    CHALLENGE_PATH = '/.well-known/acme-challenge/'

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'].start_with?(CHALLENGE_PATH) && env['PATH_INFO'].include?(challenge)
        return [200, {'Content-Type' => 'text/plain'}, [response]]
      end

      @app.call(env)
    end

    def challenge
      ENV.fetch('ACME_CHALLENGE')
    end

    def response
      ENV.fetch('ACME_RESPONSE')
    end
  end
end
