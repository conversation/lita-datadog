# lita-datadog

A lita plugin that listens for events and submits the data to Datadog. It's
not much use on its own - it's intended to be used in as a common dependency
of other lita plugins that need to submit to datadog.

## Installation

Add this gem to your lita installation by including the following line in your Gemfile:

    gem "lita-datadog"

## Configuration

Add the following to your lita_config.rb file:

    config.handlers.datadog.key = "datadog-api-key"

## Submitting Data to Datadog

To submit data, emit an event on the lita eventbus. Each event must have four attributes:

* name - a string that defines the metric name
* type - :gauge or :counter
* host - a string that describes the data host. Often a hostname
* value - a number

All four attributes are passed directly to the `dogapi` gem - check its
documentation for more details.

    class ExampleHandler < Lita::Handlers::Handler

      route(/datadog test/i, :datadog_test

      def datadog_test(response)
        data = {
          name: "ci.job-runtime.#{event.pipeline_slug}.#{event.job_slug}",
          type: :gauge,
          host: event.agent_hostname,
          value: 2
        }
        robot.trigger(:datadog_submit, data)

        response.reply("test done")
      end
    end
