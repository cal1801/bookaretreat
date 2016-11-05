require 'test_helper'

class CampInfosControllerTest < ActionController::TestCase
  setup do
    @camp_info = camp_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:camp_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create camp_info" do
    assert_difference('CampInfo.count') do
      post :create, camp_info: { camp_id: @camp_info.camp_id, description: @camp_info.description, type_id: @camp_info.type_id, url: @camp_info.url }
    end

    assert_redirected_to camp_info_path(assigns(:camp_info))
  end

  test "should show camp_info" do
    get :show, id: @camp_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @camp_info
    assert_response :success
  end

  test "should update camp_info" do
    patch :update, id: @camp_info, camp_info: { camp_id: @camp_info.camp_id, description: @camp_info.description, type_id: @camp_info.type_id, url: @camp_info.url }
    assert_redirected_to camp_info_path(assigns(:camp_info))
  end

  test "should destroy camp_info" do
    assert_difference('CampInfo.count', -1) do
      delete :destroy, id: @camp_info
    end

    assert_redirected_to camp_infos_path
  end
end
