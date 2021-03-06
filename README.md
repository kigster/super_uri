[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/super_uri?type=total)](https://rubygems.org/gems/super_uri)
[![Gem Version](https://badge.fury.io/rb/super_uri.svg)](https://badge.fury.io/rb/super_uri)

[![Build Status](https://travis-ci.org/kigster/super_uri.svg?branch=master)](https://travis-ci.org/kigster/super_uri)
[![Code Climate](https://codeclimate.com/repos/5891c85f589f751f200065c2/badges/8fd45e0f3d49012a23c6/gpa.svg)](https://codeclimate.com/repos/5891c85f589f751f200065c2/feed)
[![Test Coverage](https://codeclimate.com/repos/5891c85f589f751f200065c2/badges/8fd45e0f3d49012a23c6/coverage.svg)](https://codeclimate.com/repos/5891c85f589f751f200065c2/coverage)
[![Issue Count](https://codeclimate.com/repos/5891c85f589f751f200065c2/badges/8fd45e0f3d49012a23c6/issue_count.svg)](https://codeclimate.com/repos/5891c85f589f751f200065c2/feed)

> **WARNING**: This gem is currently under active development, and is not yet stable. Use at your own risk.

# SuperURI — Uniformly Locate Data Anywhere :) 

## Summary

This gem aims to combine the extensibility of the `URI` class — its design supports adding new and custom URI __schemes__, with the `open` and `read` semantics of the `OpenURI` standard ruby module, and aims to greatly expand the list of URIs that can be read. 

Eventually this gem might also offer ability to **write** data to the URI.

## Usage

As much as possible, we wanted to extend the existing `OpenURI` interface:

```ruby
require 'super_uri'

contents = URI([String]).read

URI.parse([String]).open do |file|
  #...
end
```

### Additional Schemes
 
The key to this gem is the large selection of the URIs that can be provided and instantly used to read data. Let's take a look at a few examples:

```ruby
require 'super_uri'

URI('env://HOME').read
# => "/Users/"

URI('file:///usr/local/etc/hosts').read
# => "127.0.0.1    localhost\n...."

URI('redis:///1/mykey').read
# => "keyvalue"

```

Future versions might allow writing and deleting of the data:

```ruby
# 
URI('file:///usr/local/etc/hosts').write(data)
# => 23425
URI('file:///usr/local/etc/hosts').delete
# => true

URI('redis:///1/mykey').write('keyvalue')
# => 8
URI('redis:///1/mykey').delet
# => true
```


### Motivation

This gem was born out of the desire to easily read and write data via a large number of ways during development of another gem — [sym](https://github.com/kigster/sym) — which performs symmetric encryption, and needs to read the private key and the data, and write the result (and sometimes the private key). After running out of flags to pass indiciating how exactly the private key is supplied, I had an epiphany — what if I can just use one flag with the data source URI? 

### Approach

There are two high-level steps required to create a unified way of reading/writing various resources:

 1. One must define the syntax for describing how to access it
 2. One must implement the actual read/write code for each supported syntax.

The most natural fit for 1 seems to be the `URI` module. It can be easily extended by design, and already supports many schemes out the box. In addition, a popular `OpenURI` extension adds the `open` call to `http[s]`, `ftp`, and `ssh` protocols, partially providing #2 for these schemes.

However, `OpenURI` only supports a few protocols, and does not currently support *delete* operation. 

The approach we take is to extend `URI` with the schemes with support, and fulfill them using `Handlers` that can be easily added.

## Supported URIs

The following types are planned to be supported:

##### Environment Variables

```ruby
URI('env://HOME').read
# => /Users/kig
```
##### Redis

###### Read/Write Hash Value by Key

```ruby
URI('redis://localhost:6379/1/firstname').write('konstantin')
# => 'OK'
URI('redis://localhost:6379/1/firstname').read
# => 'konstantin'
```

###### Any Operation?

```ruby
URI('redis://localhost:6379/1/operation').run(*args)
```

##### File Operation

```ruby
URI('scp://user@host/path/file').delete
```

Suggested possible ways of accessing local and remote data:

```ruby
URI('string://value').read
# => "value"

URI('env://PATH').read
# => "/bin:/usr/bin:/usr/local/bin"

URI('stdin:/').read
# => data from STDIN until EOF

URI('shell://echo%20hello').read
# => "hello"

URI('redis://127.0.0.1:6397/1/get,firstname').read
# => 'konstantin'
```

Similarly, we could read data from:

    memcached://127.0.0.1:11211/operation,arg1,arg2,...
    scp://user@host/path/file        
    postgresql://user@host/db/?sql=<sql-query>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'super_uri'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install super_uri


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kigster/super_uri.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

