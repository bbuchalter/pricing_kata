class CheckOut

  attr_reader :total, :scanned_items

  def initialize(rules)
    @rules = rules
    @total = 0
    @scanned_items = []
  end

  def scan(sku)
    @scanned_items << sku
    self.total = self.total + price(sku)
  end

  private

  attr_reader :rules
  attr_writer :total

  def price(sku)
    eligible_rule = rules.find { |r| r.eligible?(sku, scanned_items) }
    price = eligible_rule.price(sku, scanned_items)
    price
  end
end