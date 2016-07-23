require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @guest_user = users(:guestie)
  end
  
  # setup do
  #   @request.env['HTTP_REFERER'] = 'http://test.com/'
  # end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "DrawParty"
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign up | DrawParty"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | DrawParty"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | DrawParty"
  end

  test "should redirect edit when not logged in" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    log_in_as(@other_user)
    patch user_path(@user), user: { username: @user.username,
                                    email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
  test "Cant report yourself" do
    log_in_as(@user)
    reportCount = @user.reports
    put report_path(@user) 
    assert_not flash.empty?

    assert_equal @user.reports, reportCount
  end
  
  test "Cant commend yourself" do
    log_in_as(@user)
    commendCount = @user.commends
    put commend_path(@user)
    assert_not flash.empty?
    assert_equal @user.commends, commendCount
  end
  
  test "reporting another user" do
    log_in_as(@user)
    assert_difference '@other_user.reports', 1 do
      put report_path(@other_user)
    end
    # reportCount = @other_user.reports
    
    assert flash.empty?
    # assert_not_equal @other_user.reports, reportCount, "the report count is #{reportCount}, actual count is #{@other_user.reports}"
  end
  test "commending another user" do
    log_in_as(@user)
    commendCount = @other_user.commends
    put commend_path(@other_user)
  #   assert_not_equal @other_user.commends, commendCount, "the commend count is #{commendCount}, actual count is #{@other_user.commends}"
  end
end