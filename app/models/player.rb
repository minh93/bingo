class Player < ActiveRecord::Base
<<<<<<< HEAD
	validates :name, uniqueness: true
=======
  validates :name, presence: true, uniqueness: true
  serialize :card
  serialize :row
  serialize :column
  serialize :diagonal
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
end
