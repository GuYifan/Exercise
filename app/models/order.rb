class Order < ApplicationRecord

  belongs_to :user

  validates :code, presence: true
  validates :user, presence: true

  def self.place_an_order cart, user_id
    success = false
    # binding.pry
    if user_id.present? && cart.present?
      item_ids  = ShopItem.where(id: cart).pluck(:id).join(',')
      ord       = Order.create user_id: user_id, code: item_ids
      success = true if ord && ord.id.present?
    end

    success
  end

  class << self

    def user_order_stats user_id
      # Method description:
      # as an input it should be user_id for whom we want to see statistics
      # If user got at least 1 order we should output array in the following format
      # [ Array of all ordered names, quantity of uniq items ordered, quantity of all items ordered * 2 ]
      # EX: [ ["Coconut", "Guava"], 3, 14 ]
      # If there is no orders for that user - we should output blank array
      # If user is not exists output should be blank array
      # binding.pry
      user  = User.where(id: user_id).first
      ids   = Order.where(user_id: user.id).pluck(:code)

      if ids.present?
        item_names      = ShopItem.where(id: ids).collect{|t| t.name.humanize }
        item_ids_uniq_c = ids.uniq.length
        item_ids_c      = ids.length
        [ item_names, item_ids_uniq_c, item_ids_c*2 ]
      else
        Array.new.class.new.try(:to_i)
      end

    end

  end

end
