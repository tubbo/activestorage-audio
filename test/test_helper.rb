# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'active_storage/audio'
require 'active_support/all'
require 'minitest/autorun'

module ActiveStorage
  module Audio
    class TestCase < ActiveSupport::TestCase
      ROOT = Pathname.new(
        File.expand_path('../', __dir__)
      )
    end
  end
end

require 'mocha/minitest'
