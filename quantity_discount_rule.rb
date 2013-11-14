class QuantityDiscountRule
  def initialize(sku: sku, quantity: quantity, price: price)
    @sku = sku
    @quantity = quantity
    @discount_price = price
  end

  def eligible?(other_sku, previous_skus = [])
    return false if other_sku != sku

    count = previous_skus.count(other_sku)

    return false if count == 0
    count % quantity == 0
  end

  def price(other_sku, previous_skus = [])
    raise SkuNotEligible.new unless eligible?(other_sku, previous_skus)
    discount_price
  end

  class SkuNotEligible < RuntimeError
  end

  private

  attr_reader :sku, :quantity, :discount_price
end