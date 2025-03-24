# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'dotenv'
require 'veeam'
require 'minitest/autorun'
require 'minitest/spec'

def respond_to_template(template, object, class_name)
  template.keys do |key|
    assert object.respond_to?(key.to_sym), "method #{class_name}.#{key}"
  end
end

Dotenv.load
