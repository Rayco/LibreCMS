require 'test_helper'

class InstallersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:installers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_installer
    assert_difference('Installer.count') do
      post :create, :installer => { }
    end

    assert_redirected_to installer_path(assigns(:installer))
  end

  def test_should_show_installer
    get :show, :id => installers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => installers(:one).id
    assert_response :success
  end

  def test_should_update_installer
    put :update, :id => installers(:one).id, :installer => { }
    assert_redirected_to installer_path(assigns(:installer))
  end

  def test_should_destroy_installer
    assert_difference('Installer.count', -1) do
      delete :destroy, :id => installers(:one).id
    end

    assert_redirected_to installers_path
  end
end
