require 'spec_helper'

RSpec.describe Flimpsy::Models::Canvas do
  let(:canvas) { described_class }

  after(:each) do
    File.delete("/spec/tmp/tmp.png") if File.exist?("/spec/tmp/tmp.png")
  end

  it "should create a valid model" do
    canvas.new("/spec/tmp/tmp.png")

    expect(File.exist?("/spec/tmp/tmp.png")).to be_truthy
  end
end
