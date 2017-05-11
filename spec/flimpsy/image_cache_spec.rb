require 'spec_helper'

RSpec.describe Flimpsy::ImageCache do # rubocop:disable Metrics/BlockLength
  let(:image_cache) { described_class }
  let(:image) { Flimpsy::Models::ImageConfig }
  let(:params) do
    {
      url: "/app/spec/mussorgsky.jpg",
      height: 200,
      width: 400,
      image_format: "png"
    }
  end
  let(:dimensions) do
    {
      cached: nil,
      resized: { width: 400, height: 200 }
    }
  end
  let(:token) { image.from_params(params[:url], params[:width], params[:height], params[:image_format]) }

  it "should create a valid model" do
    cached = "/tmp/flimpsy/8f28024b9d87888b3722ffacf8a3ff6a"
    resized = "/tmp/flimpsy/8f28024b9d87888b3722ffacf8a3ff6a_400x200.png"

    expect(token.cached).to eq(cached)
    expect(token.resized).to eq(resized)
  end

  describe "#resize_with_options" do
    after(:each) do
      File.delete(token.cached) if File.exist?(token.cached)
      File.delete(token.resized) if File.exist?(token.resized)
    end
    it "should resize the image" do
      image_cache.resize_with_options(token)

      expect(File.exist?(token.resized)).to be_truthy
      expect(token.dimensions).to eq(dimensions)
    end

    it "should delete the orginal cached image" do
      image_cache.resize_with_options(token)

      expect(File.exist?(token.cached)).to be_falsy
    end
  end
end
