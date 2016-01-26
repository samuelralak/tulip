require 'test_helper'

class PaintsControllerTest < ActionController::TestCase
  setup do
    @paint = paints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paint" do
    assert_difference('Paint.count') do
      post :create, paint: { amount: @paint.amount, month: @paint.month, site_id: @paint.site_id, year: @paint.year }
    end

    assert_redirected_to paint_path(assigns(:paint))
  end

  test "should show paint" do
    get :show, id: @paint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paint
    assert_response :success
  end

  test "should update paint" do
    patch :update, id: @paint, paint: { amount: @paint.amount, month: @paint.month, site_id: @paint.site_id, year: @paint.year }
    assert_redirected_to paint_path(assigns(:paint))
  end

  test "should destroy paint" do
    assert_difference('Paint.count', -1) do
      delete :destroy, id: @paint
    end

    assert_redirected_to paints_path
  end
end
