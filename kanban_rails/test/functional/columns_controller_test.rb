require 'test_helper'

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

  def test_should_create_column
    assert_difference('Column.count') do
      post :create, :column => { }
    end

    assert_redirected_to column_path(assigns(:column))
  end

  def test_should_show_column
    get :show, :id => columns(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => columns(:one).id
    assert_response :success
  end

  def test_should_update_column
    put :update, :id => columns(:one).id, :column => { }
    assert_redirected_to column_path(assigns(:column))
  end

  def test_should_destroy_column
    assert_difference('Column.count', -1) do
      delete :destroy, :id => columns(:one).id
    end

    assert_redirected_to columns_path
  end
end
