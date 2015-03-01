class Player < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  serialize :card
  serialize :row
  serialize :column
  serialize :diagonal
  serialize :card_status

  belongs_to :deal
end
