$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'html/pipeline/redcarpet_filter'
require 'html/pipeline'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
