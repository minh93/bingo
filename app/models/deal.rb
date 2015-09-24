class Deal < ActiveRecord::Base
  ###下記のすべて、必須validateは必要ではないか？
  serialize :deal
  serialize :tempwinner_number

  id = nil
  after_save {id = self.id}

  has_many :players, dependent: :destroy
end
