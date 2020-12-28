# emoji-datasource

Ruby gem for `emoji-datasource` from NPM package https://github.com/iamcal/emoji-data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'emoji-datasource'
```

## Usage

Return all emoji data

```ruby
EmojiDatasource.data
```

Find emoji by short name

```ruby
EmojiDatasource.find_by_short_name('+1')
```

Convert emoji short name to character

```ruby
EmojiDatasource.short_name_to_char('+1') # => 👍
```

this also supports skin variations

```ruby
EmojiDatasource.short_name_to_char('+1::skin-tone-2') # => 👍
```


## Supported Ruby Versions

This library aims to support and is [tested against][github_actions] the following Ruby
implementations:

* Ruby 2.5.0
* Ruby 2.6.0
* Ruby 2.7.0
* Ruby 3.0.0

## License

The gem is available as open source under the terms of the [MIT License][license].

[github_actions]: https://github.com/jpalumickas/emoji-datasource-ruby/actions
[license]: https://raw.githubusercontent.com/jpalumickas/emoji-datasource-ruby/main/LICENSE
