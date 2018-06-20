require "lita"
require "lita/datadog_repository"

module Lita
  module Handlers
    # Listens for `datadog_submit` events on the lita event bus, and sends the details
    # to datadog. Each event should have four attributes:
    #
    #   * name (string)
    #   * type (symbol)
    #   * host (string)
    #   * value (number)
    #
    # These directly map to the attributes expected by the datadog-metrics gem - check
    # its documentation for futher details.
    #
    class Datadog < Handler

      config :api_key

      on :datadog_submit, :handle_datadog_submit

      def handle_datadog_submit(data)
        name = data.fetch(:name, nil)
        type = data.fetch(:type, nil)
        host = data.fetch(:host, nil)
        value = data.fetch(:value, nil)

        raise ArgumentError, "datadog_submit event must include key :name" unless name
        raise ArgumentError, "datadog_submit event must include key :type" unless type
        raise ArgumentError, "datadog_submit event must include key :host" unless host
        raise ArgumentError, "datadog_submit event must include key :value" unless value

        puts "datadog event. name=#{name} type=#{type} host=#{host} value=#{value}"
        datadog_repository.submit(name.to_s, type: type.to_sym, value: value, host: host.to_s)
      end

      def datadog_repository
        @datadog_repository ||= DatadogRepository.new(config.api_key)
      end

    end

    Lita.register_handler(Datadog)
  end
end
