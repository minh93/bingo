class Deal < ActiveRecord::Base
  serialize :deal

  id = nil
  after_save {id = self.id}

  has_many :players, dependent: :destroy
end
