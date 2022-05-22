module Admin::ItemsHelper
  def number_to_currency(price)
    "#{price.to_s(:delimited, delimiter: ',')}円"
  end
end
