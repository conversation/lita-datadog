require 'dogapi'

module Lita
  class DatadogRepository
    def initialize(api_key)
      @Datadog_client = Dogapi::Client.new(api_key)
    end

    def submit(metric_name, metric_value, opts)
      @Datadog_client.emit_point(metric_name, metric_value, opts)
    end
  end
end
