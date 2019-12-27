# frozen_string_literal: true

module ActiveStorage
  module Audio
    # Rails hook that automatically appends
    # `ActiveStorage::Audio::Analyzer` to the collection of analyzers
    # that `ActiveStorage` will run on uploaded files.
    class Engine < Rails::Engine
      config.active_storage.analyzers.append ActiveStorage::Audio::Analyzer
    end
  end
end
