require "test/unit"
require_relative "../quantity_discount_rule"

class QuantityDiscountRuleTest < Test::Unit::TestCase
  def test_price
    assert_equal 30, subject.price("A", ["A", "A", "A"])
    assert_equal 30, subject.price("A", ["A", "A", "A", "A", "A", "A"])
    assert_raise(QuantityDiscountRule::SkuNotEligible) { subject.price("A", []) }
    assert_raise(QuantityDiscountRule::SkuNotEligible) { subject.price("B") }
  end

  def test_eligible
    assert subject.eligible?("A", ["A", "A", "A"])
    assert subject.eligible?("A", ["A", "A", "A", "A", "A", "A"])
    assert !subject.eligible?("B", ["A", "A"])
    assert !subject.eligible?("A", [])
  end

  private

  def subject
    QuantityDiscountRule.new(sku: "A", quantity: 3, price: 30)
  end
end