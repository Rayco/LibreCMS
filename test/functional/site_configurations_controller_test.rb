require 'test_helper'

class SiteConfigurationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:site_configurations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_site_configuration
    assert_difference('SiteConfiguration.count') do
      post :create, :site_configuration => { }
    end

    assert_redirected_to site_configuration_path(assigns(:site_configuration))
  end

  def test_should_show_site_configuration
    get :show, :id => site_configurations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => site_configurations(:one).id
    assert_response :success
  end

  def test_should_update_site_configuration
    put :update, :id => site_configurations(:one).id, :site_configuration => { }
    assert_redirected_to site_configuration_path(assigns(:site_configuration))
  end

  def test_should_destroy_site_configuration
    assert_difference('SiteConfiguration.count', -1) do
      delete :destroy, :id => site_configurations(:one).id
    end

    assert_redirected_to site_configurations_path
  end
end
