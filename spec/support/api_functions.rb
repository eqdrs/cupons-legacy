module ApiFunctions
  def parse_json
    JSON.parse(response.body, symbolize_names: true)
  end

  def url_from_collection(record)
    "/api/#{record.class.table_name}/#{record.id}"
  end

  def url_index(record)
    "/api/#{record[0].class.table_name}"
  end

  def url_burn_coupon(code)
    "/api/coupons/#{code}/burn"
  end

  def url_next_coupon(promotion)
    "/api/promotions/#{promotion.id}/next_coupon"
  end

  def url_for_coupon(coupon)
    "/api/coupons/#{coupon.code}"
  end
end
