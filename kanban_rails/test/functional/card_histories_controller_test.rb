require 'test_helper'

class CardHistoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:card_histories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_card_history
    assert_difference('CardHistory.count') do
      post :create, :card_history => { }
    end

    assert_redirected_to card_history_path(assigns(:card_history))
  end

  def test_should_show_card_history
    get :show, :id => card_histories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => card_histories(:one).id
    assert_response :success
  end

  def test_should_update_card_history
    put :update, :id => card_histories(:one).id, :card_history => { }
    assert_redirected_to card_history_path(assigns(:card_history))
  end

  def test_should_destroy_card_history
    assert_difference('CardHistory.count', -1) do
      delete :destroy, :id => card_histories(:one).id
    end

    assert_redirected_to card_histories_path
  end
end
