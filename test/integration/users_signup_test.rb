require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" }
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.signUp'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { username:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } 
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  test "valid guest login" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { } 
    end
    follow_redirect!
    assert_template 'users/home'
    assert is_logged_in?
  end
end