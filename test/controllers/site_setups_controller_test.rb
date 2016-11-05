require 'test_helper'

class SiteSetupsControllerTest < ActionController::TestCase
  setup do
    @site_setup = site_setups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_setups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_setup" do
    assert_difference('SiteSetup.count') do
      post :create, site_setup: { group_local_bath: @site_setup.group_local_bath, group_sep_bath: @site_setup.group_sep_bath, hotel: @site_setup.hotel, rustic: @site_setup.rustic, rv: @site_setup.rv }
    end

    assert_redirected_to site_setup_path(assigns(:site_setup))
  end

  test "should show site_setup" do
    get :show, id: @site_setup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_setup
    assert_response :success
  end

  test "should update site_setup" do
    patch :update, id: @site_setup, site_setup: { group_local_bath: @site_setup.group_local_bath, group_sep_bath: @site_setup.group_sep_bath, hotel: @site_setup.hotel, rustic: @site_setup.rustic, rv: @site_setup.rv }
    assert_redirected_to site_setup_path(assigns(:site_setup))
  end

  test "should destroy site_setup" do
    assert_difference('SiteSetup.count', -1) do
      delete :destroy, id: @site_setup
    end

    assert_redirected_to site_setups_path
  end
end
