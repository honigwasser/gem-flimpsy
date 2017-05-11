require 'spec_helper'

RSpec.describe Flimpsy::ParamsValidation do # rubocop:disable Metrics/BlockLength
  let(:validation) { described_class }

  context "valid params" do
    it "should accept valid params" do
      params = { to_file: "foo.png", from_keywords: "love, hate" }

      expect { validation.validate!(params) }.not_to raise_error
    end
  end

  context "invalid params" do
    it "should raise when path is not a png" do
      params = { to_file: "foo", from_keywords: "love, hate" }
      expect { validation.validate!(params) }.to raise_error(Flimpsy::FlimpsyError)
    end

    it "should raise when path does not exist" do
      params = { to_file: "/foo/foo.png", from_keywords: "love, hate" }
      expect { validation.validate!(params) }.to raise_error(Flimpsy::FlimpsyError)
    end

    it "should raise when path is missing" do
      params = { from_keywords: "love, hate" }
      expect { validation.validate!(params) }.to raise_error(Flimpsy::FlimpsyError)
    end

    it "should raise when keywords are missing" do
      params = { to_file: "foo.png" }
      expect { validation.validate!(params) }.to raise_error(Flimpsy::FlimpsyError)
    end

    it "should raise when keywords are empty" do
      params = { to_file: "foo.png", from_keywords: "" }
      expect { validation.validate!(params) }.to raise_error(Flimpsy::FlimpsyError)
    end
  end
end
