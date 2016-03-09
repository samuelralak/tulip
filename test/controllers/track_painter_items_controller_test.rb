require 'test_helper'

class TrackPainterItemsControllerTest < ActionController::TestCase
  setup do
    @track_painter_item = track_painter_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:track_painter_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create track_painter_item" do
    assert_difference('TrackPainterItem.count') do
      post :create, track_painter_item: { daily_allowance: @track_painter_item.daily_allowance, daily_wage: @track_painter_item.daily_wage, date_attended: @track_painter_item.date_attended, site_id: @track_painter_item.site_id, track_painter_id: @track_painter_item.track_painter_id }
    end

    assert_redirected_to track_painter_item_path(assigns(:track_painter_item))
  end

  test "should show track_painter_item" do
    get :show, id: @track_painter_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @track_painter_item
    assert_response :success
  end

  test "should update track_painter_item" do
    patch :update, id: @track_painter_item, track_painter_item: { daily_allowance: @track_painter_item.daily_allowance, daily_wage: @track_painter_item.daily_wage, date_attended: @track_painter_item.date_attended, site_id: @track_painter_item.site_id, track_painter_id: @track_painter_item.track_painter_id }
    assert_redirected_to track_painter_item_path(assigns(:track_painter_item))
  end

  test "should destroy track_painter_item" do
    assert_difference('TrackPainterItem.count', -1) do
      delete :destroy, id: @track_painter_item
    end

    assert_redirected_to track_painter_items_path
  end
end
