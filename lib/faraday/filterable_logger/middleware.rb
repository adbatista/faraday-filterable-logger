require "faraday"
require 'forwardable'

module Faraday
  module FilterableLogger
    class Middleware < Faraday::Response::Middleware
      extend Forwardable

      DEFAULT_OPTIONS = { headers: true, bodies: false }

      def initialize(app, logger = nil, options = {})
        super(app)
        @logger = logger || begin
          require 'logger'
          ::Logger.new(STDOUT)
        end
        @options = DEFAULT_OPTIONS.merge(Hash(options[:log_options]))
        @filter  = Array(options[:filter])
      end

      def_delegators :@logger, :debug, :info, :warn, :error, :fatal

      def call(env)
        env = Env.new(env, @filter)

        info "#{env.http_verb.upcase} #{env.dump_url}"
        debug('request') { env.headers } if log_headers?(:request)
        debug('request') { env.dump_body } if env.has_body? && log_body?(:request)
        super
      end

      def on_complete(env)
        env = Env.new(env, @filter)

        info('Status') { env.status }
        debug('response') { env.headers } if log_headers?(:response)
        debug('response') { env.dump_body } if env.has_body? && log_body?(:response)
      end

      private

      def log_headers?(type)
        case @options[:headers]
        when Hash then @options[:headers][type]
        else @options[:headers]
        end
      end

      def log_body?(type)
        case @options[:bodies]
        when Hash then @options[:bodies][type]
        else @options[:bodies]
        end
      end
    end
  end
end

Faraday::Response.register_middleware(
  filterable_logger: Faraday::FilterableLogger::Middleware
)
