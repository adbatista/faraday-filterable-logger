require "spec_helper"

describe Faraday::FilterableLogger::Filter do
  describe "#filter_url" do
    subject { described_class.new(:token) }

    let(:url) do
      URI("http://foo.bar?token=sometoken&format=json")
    end

    it "replaces the filtered param value with [FILTERED]" do
      expect(subject.filter_url(url)).to eq(URI("http://foo.bar?token=[FILTERED]&format=json"))
    end
  end
end
