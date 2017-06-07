# Snowflakes

Snowflakes is a [Ruby](https://www.ruby-lang.org/) gem that provides:
 * A simple 128-bit id generator.
 * Methods to convert snowflakes ID into string

Snowflakes produces 128-bit and time-ordered ids. They run one on each node in infrastructure and will generate conflict-free ids on-demand without coordination.

The project is inspired by [Twitter's Snowflake](https://github.com/twitter/snowflake) and [Go implementation of Discord](https://github.com/bwmarrin/snowflake) but extended to 128-bit and not compatible with Twitter's Snowflake. This library provides a basis for id generation but not a service for handing out ids nor node id coordination.

## Getting Started

### Installation

```sh
gem install snowflakes
```

Or via bundler:
```
source 'https://rubygems.org'

gem 'snowflakes'
```

### Usage

```ruby
node = Snowflakes::Node.new(ENV['SNOWFLAKE_ID'])

some_id = node.next.to_hex
```

### Format

Snowflakes ids are 128-bits wide described here from most significant to least significant bits:
* timestamp (64-bit) - milliseconds since the epoch (Jan 1 1970)
* node id(48-bit) - a configurable node id
* sequence (16-bit) - usually 0, increasing when more than one request in the same millisecond and reset to 0 when clock ticks forward

#### System Clock Dependency

You should use NTP to keep your system clock accurate. Snowflakes holds requests when non-monotonic clock detected. To run in a mode where NTP not move the clock backwards, see http://wiki.dovecot.org/TimeMovedBackwards#Time_synchronization for tips on how to do this.

## Related Projects

* [progamesigner/snowflakes-php](https://github.com/progamesigner/snowflakes-php)

## Maintainers

[@progamesigner](https://github.com/progamesigner).

## Contribute

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that I can review your changes

## License
[MIT](LICENSE) © Yang Sheng Han
