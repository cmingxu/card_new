class CommonResourceDetail < ActiveRecord::Base
  belongs_to :common_resource

  def is_counter_card_type?
    common_resource.is_card_type? && detail_name == CommonResource::Type_Connter_Name
  end

  def is_balance_card_type?
    common_resource.is_card_type? && detail_name == CommonResource::Type_blance_Name
  end

  def is_member_card_type?
    common_resource.is_card_type? && detail_name == CommonResource::Type_Member_Name
  end

  def is_zige_card_type?
    common_resource.is_card_type? && detail_name == CommonResource::Type_Zige_Name
  end

end
