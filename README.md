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
#=> EmojiDatasource::Emoji: :+1: (👍)
```

Find emoji by raw string:

```ruby
EmojiDatasource.find_by_char('👍🏾')
#=> EmojiDatasource::Emoji: :+1::skin-tone-5: (👍🏾)
```

Find emoji by unicode hex character code:

```ruby
EmojiDatasource.find_by_unified("1F469-200D-2764-FE0F-200D-1F468")
#=> EmojiDatasource::Emoji: :woman-heart-man: (👩‍❤️‍👨)
```

Convert emoji short name to character

```ruby
EmojiDatasource.short_name_to_char('+1') # => 👍
```

this also supports skin variations

```ruby
EmojiDatasource.short_name_to_char('+1::skin-tone-2') # => 👍🏻
```

Get base emoji for skin variation:

```ruby
emoji = EmojiDatasource.find_by_short_name(':+1::skin-tone-5:')
#=> EmojiDatasource::Emoji: :+1::skin-tone-5: (👍🏾)
emoji.base
#=> EmojiDatasource::Emoji: :+1: (👍)
```

## Supported Ruby Versions

This library aims to support and is [tested against][github_actions] the following Ruby
implementations:

* Ruby 2.7.0
* Ruby 3.0.0
* Ruby 3.1.0
* Ruby 3.2.0
* Ruby 3.3.0
* Ruby 3.4.0

## License

The gem is available as open source under the terms of the [MIT License][license].

[github_actions]: https://github.com/jpalumickas/emoji-datasource-ruby/actions
[license]: https://raw.githubusercontent.com/jpalumickas/emoji-datasource-ruby/main/LICENSE
