require 'dogapi'

module Lita
  class DatadogRepository
    def initialize(api_key)
      @Datadog_client = Dogapi::Client.new(api_key)
    end

    def submit(metric_name, opts)
      @Datadog_client.emit_points(metric_name => opts)
    end
  end
end
