require 'test_helper'

class FlashHelperTest < Test::Unit::TestCase
  include SproutTestCase

  context "A FlashHelper" do
    
    [
      { :input => 'com.foo.Bar', :expected => 'com.foo.Bar' }
      #{ :input => 'com/foo/Bar.as', :expected => 'com.foo.Bar' },
      #{ :input => 'com.out.HTML', :expected => 'com.out.HTML' },
      #{ :input => 'bar', :expected => 'Bar' }
    ].each do |input|
      
      should "return fully qualified classname for #{input[:input]}" do
        instance = FakeGenerator.new
        instance.input = input[:input]
        assert_equal input[:expected], instance.fully_qualified_class_name
      end
    end
  end
end

class FakeGenerator < Sprout::Generator::Base
  include FlashSDK::FlashHelper
end

