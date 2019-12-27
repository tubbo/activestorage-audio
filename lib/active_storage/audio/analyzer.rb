# frozen_string_literal: true

module ActiveStorage
  module Audio
    # Uses `ffprobe` to quickly find information about the track file, such
    # as duration, bitrate, sample rate, and its codec.
    class Analyzer < ActiveStorage::Analyzer
      # Tests whether the given `blob` is an audio file. If so, this
      # file will be analyzed by the `Audio::Analyzer`.
      #
      # @param [ActiveStorage::Blob] blob - Blob to test
      # @return [Boolean] whether `#audio?` returns true
      def self.accept?(blob)
        blob.audio?
      end

      # Metadata to add to the blob. Any empty values are omitted.
      #
      # @return [Hash]
      def metadata
        {
          duration: duration,
          bit_rate: bit_rate,
          sample_rate: sample_rate,
          codec: codec,
          channels: channels,
          channel_layout: channel_layout
        }.compact
      end

      # Duration of this audio file in seconds.
      #
      # @return [Float]
      def duration
        stream['duration'].to_f
      end

      # Bit rate of this audio file, e.g. `16.0`
      #
      # @return [Float]
      def bit_rate
        stream['bit_rate'].to_f
      end

      # Sample rate of this audio file, e.g. `44.1`
      #
      # @return [Float]
      def sample_rate
        stream['sample_rate'].to_i
      end

      # Codec used to encode this audio file.
      #
      # @return [String]
      def codec
        stream['codec']
      end

      # Number of audio channels (1 for mono, 2 for stereo)
      #
      # @return [Integer]
      def channels
        stream['channels'].to_i
      end

      # Layout of channels.
      #
      # @return [String]
      def channel_layout
        stream['channel_layout']
      end

      private

      # @private
      # @return [Hash] Raw data from `ffprobe`
      def probe
        @probe ||= download_blob_to_tempfile do |file|
          IO.popen(command(file.path)) do |output|
            JSON.parse(output.read)
          end
        end
      end

      # @private
      # @return [Hash] The first stream found in the search.
      def stream
        probe['streams'].first
      end

      # @private
      # @return [String] Output of the `ffprobe` command execution.
      def command(path)
        [
          ffprobe,
          '-show_streams',
          '-v',
          'error',
          '-print_format',
          'json',
          path
        ]
      end

      # @private
      # @return [String] Path to `ffprobe`.
      def ffprobe
        @ffprobe ||= ActiveStorage.paths[:ffprobe] || 'ffprobe'
      end
    end
  end
end
