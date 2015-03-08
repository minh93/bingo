class Player < ActiveRecord::Base

  BEGIN_CARD_INDEX = 0
  END_CARD_INDEX = 4
  CARD_SIZE = 5

  validates_uniqueness_of :name, scope: :deal_id
  validates :name, presence: true
  serialize :card
  serialize :row
  serialize :column
  serialize :diagonal
  serialize :card_status

  belongs_to :deal
  validates_presence_of :deal

  def self.find_by_status(game_id)
    where("deal_id = ? AND (reach_status = ? OR bingo_status = ?) ", game_id, true, true).order("updated_at ASC");
  end

  def self.find_by_deal_and_name(game_id, player_name)
    joins(:deal).where( players: { deal_id: game_id , name: player_name}).first
  end
end
