class Player < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  serialize :card
  serialize :row
  serialize :column
  serialize :diagonal
end
