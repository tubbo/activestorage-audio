# frozen_string_literal: true

require 'test_helper'

module ActiveStorage
  module Audio
    class AnalyzerTest < TestCase
      setup do
        @file = ROOT.join('test', 'fixtures', 'files', 'one.mp3')
        @analyzer = Analyzer.new(@file)
      end

      test 'only analyze audio files' do
        audio = mock('ActiveStorage::Blob', audio?: true)
        image = mock('ActiveStorage::Blob', audio?: false)

        assert Analyzer.accept?(audio)
        refute Analyzer.accept?(image)
      end

      test 'metadata' do
        keys = %i[duration bit_rate sample_rate channels channel_layout]

        assert_equal keys, @analyzer.metadata.keys
      end

      test 'duration' do
        assert_equal 42.03102, @analyzer.duration
      end

      test 'bit rate' do
        assert_equal 279_910.0, @analyzer.bit_rate
      end

      test 'sample rate' do
        assert_equal 44_100, @analyzer.sample_rate
      end

      test 'codec' do
        assert_nil @analyzer.codec
      end

      test 'channels' do
        assert_equal 2, @analyzer.channels
      end

      test 'channel layout' do
        assert_equal 'stereo', @analyzer.channel_layout
      end
    end
  end
end
