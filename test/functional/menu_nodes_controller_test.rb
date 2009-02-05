require 'test_helper'

class MenuNodesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:menu_nodes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_menu_node
    assert_difference('MenuNode.count') do
      post :create, :menu_node => { }
    end

    assert_redirected_to menu_node_path(assigns(:menu_node))
  end

  def test_should_show_menu_node
    get :show, :id => menu_nodes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => menu_nodes(:one).id
    assert_response :success
  end

  def test_should_update_menu_node
    put :update, :id => menu_nodes(:one).id, :menu_node => { }
    assert_redirected_to menu_node_path(assigns(:menu_node))
  end

  def test_should_destroy_menu_node
    assert_difference('MenuNode.count', -1) do
      delete :destroy, :id => menu_nodes(:one).id
    end

    assert_redirected_to menu_nodes_path
  end
end
