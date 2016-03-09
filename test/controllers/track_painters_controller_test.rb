require 'test_helper'

class TrackPaintersControllerTest < ActionController::TestCase
  setup do
    @track_painter = track_painters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:track_painters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create track_painter" do
    assert_difference('TrackPainter.count') do
      post :create, track_painter: {  }
    end

    assert_redirected_to track_painter_path(assigns(:track_painter))
  end

  test "should show track_painter" do
    get :show, id: @track_painter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @track_painter
    assert_response :success
  end

  test "should update track_painter" do
    patch :update, id: @track_painter, track_painter: {  }
    assert_redirected_to track_painter_path(assigns(:track_painter))
  end

  test "should destroy track_painter" do
    assert_difference('TrackPainter.count', -1) do
      delete :destroy, id: @track_painter
    end

    assert_redirected_to track_painters_path
  end
end
