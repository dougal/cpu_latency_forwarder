require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/minitest'

lib_path = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'cpu_latency_forwarder'

