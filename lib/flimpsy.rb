require "active_support/core_ext/hash"
require "active_support/core_ext/time"
require "active_support/core_ext/object/deep_dup"
require "active_support/core_ext/object/blank"
require "sys-uname"
require "oily_png"
require "virtus"

require "flimpsy/app"
require "flimpsy/params_validation"
require "flimpsy/image_cache"
require "flimpsy/api/flickr"
require "flimpsy/models/flickr_image"
require "flimpsy/models/image_config"
require "flimpsy/models/canvas"

module Flimpsy
  AGENT = "flimpsy".freeze
  IMAGE_CACHE = File.join(Etc.systmpdir, AGENT).freeze

  def self.create(params)
    Flimpsy::App.run(params)
  end
end
