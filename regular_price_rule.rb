class RegularPriceRule
  def initialize(prices)
    @prices = prices
  end

  def price(sku, previous_skus = [])
    return nil unless eligible?(sku, previous_skus)
    prices.fetch(sku)
  end

  def eligible?(sku, previous_skus = [])
    prices.keys.include?(sku)
  end

  private

  attr_reader :prices
end