require 'test_helper'

class PaintersControllerTest < ActionController::TestCase
  setup do
    @painter = painters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:painters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create painter" do
    assert_difference('Painter.count') do
      post :create, painter: { basic_pay: @painter.basic_pay, daily_wage: @painter.daily_wage, dailyy=_allowance: @painter.dailyy=_allowance, employment_type_id: @painter.employment_type_id, name: @painter.name }
    end

    assert_redirected_to painter_path(assigns(:painter))
  end

  test "should show painter" do
    get :show, id: @painter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @painter
    assert_response :success
  end

  test "should update painter" do
    patch :update, id: @painter, painter: { basic_pay: @painter.basic_pay, daily_wage: @painter.daily_wage, dailyy=_allowance: @painter.dailyy=_allowance, employment_type_id: @painter.employment_type_id, name: @painter.name }
    assert_redirected_to painter_path(assigns(:painter))
  end

  test "should destroy painter" do
    assert_difference('Painter.count', -1) do
      delete :destroy, id: @painter
    end

    assert_redirected_to painters_path
  end
end
