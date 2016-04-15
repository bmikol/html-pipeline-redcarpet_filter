# HTML::Pipeline::RedcarpetFilter

[![Build Status](https://travis-ci.org/bmikol/html-pipeline-redcarpet_filter.svg?branch=master)](https://travis-ci.org/bmikol/html-pipeline-redcarpet_filter) [![Dependency Status](https://www.versioneye.com/user/projects/57110ea3fcd19a004544102a/badge.svg?style=flat)](https://www.versioneye.com/user/projects/57110ea3fcd19a004544102a)

[Redcarpet](https://github.com/vmg/redcarpet) integration for [HTML::Pipeline](https://github.com/jch/html-pipeline). 

This was developed with the intention to be a drop-in replacement for HTML::Pipeline's bundled MarkdownPipeline which depends on the unsupported ```github-markdown``` gem. To that end, currently only ```:autolink``` and ```:fenced_code_blocks``` are enabled with Redcarpet's default filter options; future version to add/remove options with a context hash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html-pipeline-redcarpet_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html-pipeline-redcarpet_filter

## Usage

```ruby
require 'html/pipeline'
require 'html/pipeline/redcarpet_filter'

pipeline = HTML::Pipeline.new [
  HTML::Pipeline::RedcarpetFilter
]

input = %(#Food for Thought

> Someone asked, "Do we need so many typefaces?" I replied,
> 
> * Do we need so many books?
> * Do we need another painting?
> * Do we need so many songs?
> * Do we need another movie?
> 
> -- Bill Dawson)

result = pipeline.call(input)

puts result[:output]
```

Prints:

```html
<h1>Food for Thought</h1>

<blockquote>
<p>Someone asked, &quot;Do we need so many typefaces?&quot; I replied,</p>

<ul>
<li>Do we need so many books?</li>
<li>Do we need another painting?</li>
<li>Do we need so many songs?</li>
<li>Do we need another movie?</li>
</ul>

<p>-- Bill Dawson</p>
</blockquote>
```

## Known Issue

1. Is currently incompatible for use with [HTML::Pipeline::RougeFilter](https://github.com/JuanitoFatas/html-pipeline-rouge_filter).

## Contributing

1. Fork it ( https://github.com/bmikol/html-pipeline-redcarpet_filter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Bug reports welcome.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).