class CardHistory < ActiveRecord::Base
  belongs_to :card
  belongs_to :column
end
