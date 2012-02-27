require 'spec_helper'

describe "Users" do
  describe "signup" do
    it "should not make a new user with empty fields" do
      lambda do
        visit signup_path
        fill_in "Name",         :with => ""
        fill_in "EMail",        :with => ""
        fill_in "Password",     :with => ""
        fill_in "Confirmation", :with => ""
        click_button
        response.should render_template("users/new")
        response.should have_selector("div#error_explanation")
      end.should_not change(User,:count)
    end

    it "should make a new user" do
      lambda do
        visit signup_path
        fill_in "Name",         :with => "Joe Test"
        fill_in "EMail",        :with => "joe@test.com"
        fill_in "Password",     :with => "SomePwd"
        fill_in "Confirmation", :with => "SomePwd"
        click_button
        response.should render_template("users/new")
        response.should have_selector('div.flash.success',
                                      :content => "Welcome")
      end.should change(User,:count).by(1)
    end
  end
end
