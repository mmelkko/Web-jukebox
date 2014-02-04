require 'test_helper'

class PlayQueuesControllerTest < ActionController::TestCase
  setup do
    @play_queue = play_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:play_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create play_queue" do
    assert_difference('PlayQueue.count') do
      post :create, play_queue: {  }
    end

    assert_redirected_to play_queue_path(assigns(:play_queue))
  end

  test "should show play_queue" do
    get :show, id: @play_queue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @play_queue
    assert_response :success
  end

  test "should update play_queue" do
    put :update, id: @play_queue, play_queue: {  }
    assert_redirected_to play_queue_path(assigns(:play_queue))
  end

  test "should destroy play_queue" do
    assert_difference('PlayQueue.count', -1) do
      delete :destroy, id: @play_queue
    end

    assert_redirected_to play_queues_path
  end
end
