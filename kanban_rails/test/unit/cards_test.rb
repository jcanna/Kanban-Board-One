require 'test/test_helper'

class CardsTest < ActiveSupport::TestCase

  def test_new_card_should_create_single_card_history
    card = Card.new
    card.column_id = 7
    
    assert_difference(['Card.count', 'CardHistory.count']) do
        card.save
    end 
    
    card_history = CardHistory.find(:last, :conditions => "column_id = '#{card.column_id}' AND card_id = '#{card.id}'")
    assert_equal("entered", card_history.action) 
  end
  
  def test_existing_card_moved_to_new_column_should_create_2_card_histories
    card = Card.find(:first, :conditions => "id = 1")
    card_original_column_id = card.column_id
    card.column_id = 57
    
    assert_difference('CardHistory.count', 2 ) do
      card.save
    end
        
    card_history = CardHistory.find(:last, :conditions => "column_id = '#{card_original_column_id}' AND card_id = '#{card.id}'")
    assert_equal("left", card_history.action)
    
    card_history = CardHistory.find(:last, :conditions => "column_id = '#{card.column_id}' AND card_id = '#{card.id}'")
    assert_equal("entered", card_history.action)
  end
  
  def test_card_deletion_should_create_one_card_history_entry
    card = Card.find(:first, :conditions => "id = 1")
    
    assert_difference('CardHistory.count') do
      card.destroy
    end

    card_history = CardHistory.find(:last, :conditions => "column_id = '#{card.column_id}' AND card_id = '#{card.id}'")
    assert_equal("left", card_history.action)
  end
  
end
