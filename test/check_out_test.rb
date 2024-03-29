require "test/unit"
require_relative "../check_out"
require_relative "../regular_price_rule"
require_relative "../quantity_discount_rule"

class CheckOutTest < Test::Unit::TestCase

  def price(goods)
    co = CheckOut.new(rules)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  def test_totals
    assert_equal(0, price(""))
    assert_equal(50, price("A"))
    assert_equal(80, price("AB"))
    assert_equal(115, price("CDBA"))

    assert_equal(100, price("AA"))
    assert_equal(130, price("AAA"))
    assert_equal(180, price("AAAA"))
    assert_equal(230, price("AAAAA"))
    assert_equal(260, price("AAAAAA"))

    assert_equal(160, price("AAAB"))
    assert_equal(175, price("AAABB"))
    assert_equal(190, price("AAABBD"))
    assert_equal(190, price("DABABA"))
  end

  def test_incremental
    co = CheckOut.new(rules)
    assert_equal(0, co.total)
    co.scan("A"); assert_equal(50, co.total)
    co.scan("B"); assert_equal(80, co.total)
    co.scan("A"); assert_equal(130, co.total)
    co.scan("A"); assert_equal(160, co.total)
    co.scan("B"); assert_equal(175, co.total)
  end

  def test_scan
    co = CheckOut.new(rules)
    co.scan("A")
    assert_equal ["A"], co.scanned_items
  end

  private

  def rules
    [
        QuantityDiscountRule.new(sku: "A", quantity: 3, price: 30),
        QuantityDiscountRule.new(sku: "B", quantity: 2, price: 15),
        RegularPriceRule.new({
                                 "A" => 50,
                                 "B" => 30,
                                 "C" => 20,
                                 "D" => 15
                             })
    ]
  end
end