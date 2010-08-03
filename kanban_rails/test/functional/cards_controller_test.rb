require 'test/test_helper'

class CardsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cards)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cards
      assert_difference(['Card.count', 'CardHistory.count']) do
        post :create, :card => {:name => "a new card", :column_id => columns(:column_one).id}
      end
 
    created_card_id = Hash.from_xml(@response.body).values.first['id']
    assert_equal(5, Card.find(created_card_id).position, "The newly created card should be in the last position")
  end

  def test_should_show_cards
    get :show, :id => cards(:col_one_position_one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => cards(:col_one_position_one).id
    assert_response :success
  end

  def test_should_update_card_order_when_position_changes_in_column
    assert_column_one_original_order
    
    card = Card.find(cards(:col_one_position_one).id)
    card.position = 3
    put :update, :id => card.id, :card => card.attributes
    
    assert_equal(1, Card.find(cards(:col_one_position_two).id).position, "Card two's position should have changed to be one")
    assert_equal(2, Card.find(cards(:col_one_position_three).id).position, "Card three's position should have changed to be two")
    assert_equal(3, Card.find(cards(:col_one_position_one).id).position, "Card one's position should have changed to be three")
    assert_equal(4, Card.find(cards(:col_one_position_four).id).position, "Card four's position should still be four")
  end
  
  def test_should_update_column_and_card_position
    assert_column_one_original_order
    assert_column_two_original_order
    assert_equal(21, Card.find(cards(:col_one_position_one).id).days_in_column, "Card col_one_position_one should be 21 days in column")
    
    card = Card.find(cards(:col_one_position_one).id)
    card.position = 3                                   # different position
    card.column_id = columns(:column_two).id            # different column
    
    assert_difference('CardHistory.count', 2 ) do
      put :update, :id => card.id, :card => card.attributes
    end

    assert_equal(0, Card.find(cards(:col_one_position_one).id).days_in_column, "Card col_one_position_one should now be less than one day in column")
    
    assert_equal(3, Card.find(:all, :conditions => {:column_id => columns(:column_one).id}).length, "Column one should now have 3 cards.")
    assert_equal(1, Card.find(cards(:col_one_position_two).id).position, "Card col_one_position_two should now be in position two")
    assert_equal(2, Card.find(cards(:col_one_position_three).id).position, "Card col_one_position_three should now be in position three")
    assert_equal(3, Card.find(cards(:col_one_position_four).id).position, "Card col_one_position_four should now be in position four")
    
    assert_equal(5, Card.find(:all, :conditions => {:column_id => columns(:column_two).id}).length, "Column two should now have 5 cards.")
    assert_equal(1, Card.find(cards(:col_two_position_one).id).position, "Card col_two_position_one is expected to now be in position one")
    assert_equal(2, Card.find(cards(:col_two_position_two).id).position, "Card col_two_position_two should now be in position two")
    assert_equal(3, Card.find(cards(:col_one_position_one).id).position, "Card col_one_position_one should now be in position three")
    assert_equal(4, Card.find(cards(:col_two_position_three).id).position, "Card col_two_position_three should now be in position four")
    assert_equal(5, Card.find(cards(:col_two_position_four).id).position, "Card col_two_position_four should now be in position five")
    
  end
  
 def assert_column_one_original_order
    assert_equal(1, Card.find(cards(:col_one_position_one).id).position, "Card col_one_position_one is expected to start out in position one")
    assert_equal(2, Card.find(cards(:col_one_position_two).id).position, "Card col_one_position_two should start out in position two")
    assert_equal(3, Card.find(cards(:col_one_position_three).id).position, "Card col_one_position_three should start out in position three")
    assert_equal(4, Card.find(cards(:col_one_position_four).id).position, "Card col_one_position_four should start out in position four")
 end
 
 def assert_column_two_original_order
    assert_equal(1, Card.find(cards(:col_two_position_one).id).position, "Card col_two_position_one is expected to start out in position one")
    assert_equal(2, Card.find(cards(:col_two_position_two).id).position, "Card col_two_position_two should start out in position two")
    assert_equal(3, Card.find(cards(:col_two_position_three).id).position, "Card col_two_position_three should start out in position three")
    assert_equal(4, Card.find(cards(:col_two_position_four).id).position, "Card col_two_position_four should start out in position four")
 end

  def test_should_destroy_cards
    assert_difference('CardHistory.count') do
      assert_difference('Card.count', -1) do
        delete :destroy, :id => cards(:col_one_position_one).id
      end
    end
    
    assert_equal(1, Card.find(cards(:col_one_position_two).id).position, "After delete col_one_position_two should be in position one")
    assert_equal(2, Card.find(cards(:col_one_position_three).id).position, "After delete col_one_position_three should be in position two")
    assert_equal(3, Card.find(cards(:col_one_position_four).id).position, "After delete col_one_position_four should be in position three")
  end
end
