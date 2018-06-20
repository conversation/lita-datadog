require "lita/datadog"
require "ostruct"

describe Lita::Handlers::Datadog, lita_handler: true do
  let(:handler) { Lita::Handlers::Datadog.new(robot) }
  let(:robot) { Lita::Robot.new }

  context "when buildkite sends a POST" do
    it "responds" do
      expect(handler).to route_event(:datadog_submit).to(:handle_datadog_submit)
    end
  end

  describe "#handle_datadog_submit" do
    let(:repository) { double(submit: true) }

    before do
      allow(Lita::DatadogRepository).to receive(:new) { repository }
    end

    context "with a valid event" do
      let(:payload) { {name: "test-name", type: :gauge, host: "test-source", value: 2} }

      it "sends the correct data to datadog" do
        handler.handle_datadog_submit(payload)
        expect(repository).to have_received(:submit).with("test-name", type: :gauge, value: 2, host: "test-source")
      end
    end

    context "with an event that has no name" do
      let(:payload) { { type: :gauge, host: "test-source", value: 2} }

      it "raises an exception" do
        expect {
          handler.handle_datadog_submit(payload)
        }.to raise_error(ArgumentError, "datadog_submit event must include key :name")
      end
    end

    context "with an event that has no type" do
      let(:payload) { { name: "test-name", host: "test-source", value: 2} }

      it "raises an exception" do
        expect {
          handler.handle_datadog_submit(payload)
        }.to raise_error(ArgumentError, "datadog_submit event must include key :type")
      end
    end

    context "with an event that has no host" do
      let(:payload) { {name: "test-name", type: :gauge, value: 2} }

      it "raises an exception" do
        expect {
          handler.handle_datadog_submit(payload)
        }.to raise_error(ArgumentError, "datadog_submit event must include key :host")
      end
    end

    context "with an event that has no value" do
      let(:payload) { {name: "test-name", type: :gauge, host: "test-source"} }

      it "raises an exception" do
        expect {
          handler.handle_datadog_submit(payload)
        }.to raise_error(ArgumentError, "datadog_submit event must include key :value")
      end
    end
  end
end
