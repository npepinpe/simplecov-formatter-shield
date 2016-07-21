# SimpleCov::Formatter::ShieldFormatter

SimpleCov formatter to generate status shields for your reports. Although one already existed, the idea was to create one with as little dependencies as possible, and eventually more than one backend (i.e. not strictly dependent on shields.io).

## Dependencies

If you're going to use the PNG generator, you'll need to install the following: ghostscript, librsvg, imagemagick

If you're on OSX, you can use homebrew to install all dependencies:

```
brew install ghostscript
brew install librsvg
brew install imagemagick --with-librsvg
```

Ghostscript installs the required fonts, otherwise converting from SVG to PNG would generate errors. Using librsvg will
convert SVGs to PNGs more accurately.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplecov-formatter-shield'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplecov-formatter-shield

## Usage

When initializing SimpleCov, simply add the formatter to your list of formatters.

```ruby
SimpleCov.formatter = [..., SimpleCov::Formatter::ShieldFormatter.new]
```

## Development

Use rubocop for linting, default options until a .rubocop.yml is provided.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/npepinpe/simplecov-formatter-shield.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

