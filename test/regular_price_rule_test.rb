require "test/unit"
require_relative "../regular_price_rule"

class RegularPriceTest < Test::Unit::TestCase
  def test_price
    assert_equal 10, subject.price("A")
    assert_equal nil, subject.price("C")
  end

  def test_eligible?
    assert subject.eligible?("A")
    assert !subject.eligible?("C")
  end

  private

  def subject
    RegularPriceRule.new(prices)
  end

  def prices
    prices = {"A" => 10, "B" => 20}
  end
end
