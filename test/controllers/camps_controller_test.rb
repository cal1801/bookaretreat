require 'test_helper'

class CampsControllerTest < ActionController::TestCase
  setup do
    @camp = camps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:camps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create camp" do
    assert_difference('Camp.count') do
      post :create, camp: { address_id: @camp.address_id, contact_id: @camp.contact_id, name: @camp.name, pccca_member: @camp.pccca_member, site_setup_id: @camp.site_setup_id, web_url: @camp.web_url }
    end

    assert_redirected_to camp_path(assigns(:camp))
  end

  test "should show camp" do
    get :show, id: @camp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @camp
    assert_response :success
  end

  test "should update camp" do
    patch :update, id: @camp, camp: { address_id: @camp.address_id, contact_id: @camp.contact_id, name: @camp.name, pccca_member: @camp.pccca_member, site_setup_id: @camp.site_setup_id, web_url: @camp.web_url }
    assert_redirected_to camp_path(assigns(:camp))
  end

  test "should destroy camp" do
    assert_difference('Camp.count', -1) do
      delete :destroy, id: @camp
    end

    assert_redirected_to camps_path
  end
end
