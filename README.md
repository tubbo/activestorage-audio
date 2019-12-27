# activestorage-audio

An audio analyzer for [ActiveStorage](https://guides.rubyonrails.org/active_storage_overview.html)
which will automatically analyze audio files using [FFmpeg](https://www.ffmpeg.org/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_storage-audio'
```

Then, run:

    $ bundle install

You will also need `ffmpeg` installed. On Debian-based systems, run:

```bash
$ apt-get install -y ffmpeg
```

For macOS, run:

```bash
$ brew install ffmpeg
```

## Usage

If you're running Rails, `ActiveStorage::Audio::Analyzer` will be
automatically included in the list of analyzers to run on your uploaded
files. For a manual setup, add this to your app initialization:

```ruby
require "activestorage"
require "activestorage/audio"

ActiveStorage.analyzers << ActiveStorage::Audio::Analyzer
```

The analyzer will save its data to the `metadata` Hash on an audio file
`blob`, which can be accessed in the model like so:

```ruby
class Model < ApplicationRecord
  has_attached_file :audio

  # Return the duration of this Track
  #
  # @return [Float]
  def duration
    audio.blob.metadata[:duration] if audio.attached?
  end
end
```

When you `#attach` an audio file to this model, the duration will be
computed using `ffprobe`, found using the current `$PATH`. If you wish
to set a custom path to ffprobe, do this in an initializer:

```ruby
ActiveSupport.paths[:ffprobe] = '/opt/local/bin/ffprobe'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

vBug reports and pull requests are welcome on GitHub at
https://github.com/tubbo/active_storage-audio. This project is intended
to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [code of
conduct](https://github.com/tubbo/active_storage-audio/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveStorage::Audio project's codebases,
issue trackers, chat rooms and mailing lists is expected to follow the
[code of
conduct](https://github.com/tubbo/active_storage-audio/blob/master/CODE_OF_CONDUCT.md).
