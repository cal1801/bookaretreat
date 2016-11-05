require 'test_helper'

class CampTypesControllerTest < ActionController::TestCase
  setup do
    @camp_type = camp_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:camp_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create camp_type" do
    assert_difference('CampType.count') do
      post :create, camp_type: { name: @camp_type.name }
    end

    assert_redirected_to camp_type_path(assigns(:camp_type))
  end

  test "should show camp_type" do
    get :show, id: @camp_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @camp_type
    assert_response :success
  end

  test "should update camp_type" do
    patch :update, id: @camp_type, camp_type: { name: @camp_type.name }
    assert_redirected_to camp_type_path(assigns(:camp_type))
  end

  test "should destroy camp_type" do
    assert_difference('CampType.count', -1) do
      delete :destroy, id: @camp_type
    end

    assert_redirected_to camp_types_path
  end
end
