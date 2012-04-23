require 'helper'

class DiskUtilInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::DiskUtil).configure(conf)
  end

  def test_configure
  end
end
