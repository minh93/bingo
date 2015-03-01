class Player < ActiveRecord::Base
  validates_uniqueness_of :name, scope: :deal_id
  validates :name, presence: true
  serialize :card
  serialize :row
  serialize :column
  serialize :diagonal
  serialize :card_status

  belongs_to :deal
  validates_presence_of :deal
end
