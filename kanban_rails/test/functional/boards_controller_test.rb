require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:boards)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_board
    assert_difference('Board.count') do
      post :create, :board => { }
    end

    assert_redirected_to board_path(assigns(:board))
  end

  def test_should_show_board
    get :show, :id => boards(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => boards(:one).id
    assert_response :success
  end

  def test_should_update_board
    put :update, :id => boards(:one).id, :board => { }
    assert_redirected_to board_path(assigns(:board))
  end

  def test_should_destroy_board
    assert_difference('Board.count', -1) do
      delete :destroy, :id => boards(:one).id
    end

    assert_redirected_to boards_path
  end
end
