require 'spec_helper'

RSpec.describe Flimpsy::Models::FlickrImage do
  let(:image) { described_class }
  let(:response) do
    FlickRaw::Response.new(
      {
        "id" => "1",
        "owner" => "me",
        "secret" => "secret",
        "url_z" => "http://foo",
        "tags" => "",
        "title" => "",
        "views" => 1,
        "count_faves" => 1
      }, "test"
    )
  end

  it "should create a valid model" do
    token = image.from_response(response)

    expect(token.url).to eq(response.url_z)
    expect(token.favorites).to eq(response.count_faves)
  end
end
