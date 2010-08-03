class AddCardPosition < ActiveRecord::Migration
  def self.up
    add_column :cards, :position, :integer;
    
=begin
    Card.reset_column_information
    
    Column.find(:all).each {|column|
      Card.find(:all, :conditions => "column_id = #{column.id}" ).each_with_index { |card, index|
        card.position = index + 1;
        card.save
      }
    }
=end
    
  end

  def self.down
    remove_column :cards, :position;
  end
end