require 'test_helper'

class PettyCashItemsControllerTest < ActionController::TestCase
  setup do
    @petty_cash_item = petty_cash_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:petty_cash_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create petty_cash_item" do
    assert_difference('PettyCashItem.count') do
      post :create, petty_cash_item: { amount: @petty_cash_item.amount, bal_carried_forward: @petty_cash_item.bal_carried_forward, date: @petty_cash_item.date, paid_to: @petty_cash_item.paid_to, reason: @petty_cash_item.reason }
    end

    assert_redirected_to petty_cash_item_path(assigns(:petty_cash_item))
  end

  test "should show petty_cash_item" do
    get :show, id: @petty_cash_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @petty_cash_item
    assert_response :success
  end

  test "should update petty_cash_item" do
    patch :update, id: @petty_cash_item, petty_cash_item: { amount: @petty_cash_item.amount, bal_carried_forward: @petty_cash_item.bal_carried_forward, date: @petty_cash_item.date, paid_to: @petty_cash_item.paid_to, reason: @petty_cash_item.reason }
    assert_redirected_to petty_cash_item_path(assigns(:petty_cash_item))
  end

  test "should destroy petty_cash_item" do
    assert_difference('PettyCashItem.count', -1) do
      delete :destroy, id: @petty_cash_item
    end

    assert_redirected_to petty_cash_items_path
  end
end
