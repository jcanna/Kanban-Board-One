require 'test/test_helper'
class ColumnsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:columns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_columns
    assert_difference(['Column.count'], +1) do
      post :create, :column => {:name => "a new column", :id => 9999999, :board_id => boards(:board_one).id, :position => columns.size }
    end
 
    created_column_id = Hash.from_xml(@response.body).values.first['id']
    assert_equal("a new column", Column.find(created_column_id).name, "The newly created column should exist in database")
  end

  def test_should_show_columns
    get :show, :id => columns(:column_one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => columns(:column_one).id
    assert_response :success
  end

  def test_should_update_column_order_when_position_changes_in_board
    assert_board_one_original_order

    column = Column.find(columns(:column_one).id)
    assert_not_equal(99.056, column.average_days_in_column, "Column find should recalculate average_days_in_column")
    
    column.position = 2
    put :update, :id => column.id, :column => column.attributes
    
    assert_equal(1, Column.find(columns(:column_two).id).position, "Column two's position should have changed to be one")
    assert_equal(2, Column.find(columns(:column_one).id).position, "Column one's position should have changed to be two")
    assert_equal(3, Column.find(columns(:column_three).id).position, "Column three's position should still be three")
    assert_equal(4, Column.find(columns(:column_four).id).position, "Column four's position should still be four")
  end
  
  def assert_board_one_original_order
    assert_equal(1, Column.find(columns(:column_one).id).position, "Column column_one is expected to start out in position one")
    assert_equal(2, Column.find(columns(:column_two).id).position, "Column column_two should start out in position two")
    assert_equal(3, Column.find(columns(:column_three).id).position, "Column column_three should start out in position three")
    assert_equal(4, Column.find(columns(:column_four).id).position, "Column column_four should start out in position four")
  end
 
  def test_should_destroy_columns
    assert_difference('CardHistory.count', -5) do
      assert_difference('Column.count', -1) do
        delete :destroy, :id => columns(:column_one).id
      end
    end
    
    assert_equal(1, Column.find(columns(:column_two).id).position, "After delete column_two should be in position one")
    assert_equal(2, Column.find(columns(:column_three).id).position, "After delete column_three should be in position two")
    assert_equal(3, Column.find(columns(:column_four).id).position, "After delete column_four should be in position three")
  end

end
