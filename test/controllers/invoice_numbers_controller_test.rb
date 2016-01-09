require 'test_helper'

class InvoiceNumbersControllerTest < ActionController::TestCase
  setup do
    @invoice_number = invoice_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoice_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice_number" do
    assert_difference('InvoiceNumber.count') do
      post :create, invoice_number: { invoice_date: @invoice_number.invoice_date, site_id: @invoice_number.site_id, sub_total: @invoice_number.sub_total, total: @invoice_number.total, value_added_tax: @invoice_number.value_added_tax }
    end

    assert_redirected_to invoice_number_path(assigns(:invoice_number))
  end

  test "should show invoice_number" do
    get :show, id: @invoice_number
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice_number
    assert_response :success
  end

  test "should update invoice_number" do
    patch :update, id: @invoice_number, invoice_number: { invoice_date: @invoice_number.invoice_date, site_id: @invoice_number.site_id, sub_total: @invoice_number.sub_total, total: @invoice_number.total, value_added_tax: @invoice_number.value_added_tax }
    assert_redirected_to invoice_number_path(assigns(:invoice_number))
  end

  test "should destroy invoice_number" do
    assert_difference('InvoiceNumber.count', -1) do
      delete :destroy, id: @invoice_number
    end

    assert_redirected_to invoice_numbers_path
  end
end
