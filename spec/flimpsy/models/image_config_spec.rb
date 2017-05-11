require 'spec_helper'

RSpec.describe Flimpsy::Models::ImageConfig do
  let(:image) { described_class }
  let(:params) do
    {
      url: "http://foo",
      height: 40,
      width: 40,
      background_color: "#000000",
      image_format: "jpg"
    }
  end

  it "should create a valid model" do
    token = image.from_params(params[:url], params[:width], params[:height], params[:image_format])

    cached = "/tmp/flimpsy/0e1383718a2889c12af18febb1a2e3de"
    resized = "/tmp/flimpsy/0e1383718a2889c12af18febb1a2e3de_40x40.jpg"

    expect(token.cached).to eq(cached)
    expect(token.resized).to eq(resized)
  end
end
