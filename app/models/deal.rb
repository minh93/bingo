class Deal < ActiveRecord::Base
  ###下記のすべて、必須validateは必要ではないか？
  serialize :deal
  serialize :tempwinner_number
  serialize :winnumber_type_2
  serialize :winnumber_type_3
  serialize :winnumber_type_4
  serialize :not_exist_deal

  id = nil
  after_save {id = self.id}

  has_many :players, dependent: :destroy
end
