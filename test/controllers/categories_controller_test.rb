require "test_helper"

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name:"sport")
  end

  test "shold get index" do
    get :index
    assert_response :success
  end

  test "shold get new" do
    get :new
    assert_response :success
  end

  test "shold get show" do
    get( :show, {'id' => @category.id} )
    assert_response :success
  end

end
