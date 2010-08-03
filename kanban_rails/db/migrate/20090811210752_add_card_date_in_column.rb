class AddCardDateInColumn < ActiveRecord::Migration
  def self.up

     add_column :cards, :date_in_column, :datetime

     Card.find(:all).each { |card|
        card_history = CardHistory.last(:conditions => {:card_id => card.id, :column_id => card.column_id})
        card.date_in_column = card_history == nil ? Time.now : card_history.created_at
        card.save
     }

  end

  def self.down
    remove_column :cards, :date_in_column
  end
end
