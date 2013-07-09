require 'spec_helper'

describe "Application" do
  describe "visitor signs up" do
    it "should sign them up with valid details" do
      visit '/'
      within '#signup' do
        fill_in 'First Name', :with => "Tom"
        fill_in 'Last Name', :with => "Wissy"
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
        fill_in 'Password Confirmation', :with => "Password"
        click_button 'Sign Up'
      end
      expect(page).to have_content("Sign up successful. Now login.")
    end

    it "should not sign them up with invalid details" do
      visit '/'
      within '#signup' do
        fill_in 'First Name', :with => "Tom"
        fill_in 'Last Name', :with => "Wissy"
        fill_in 'Email', :with => "invalidemail"
        fill_in 'Password', :with => "short"
        fill_in 'Password Confirmation', :with => "nonmatchingconfirmation"
        click_button 'Sign Up'
      end
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("Password is too short (minimum is 7 characters)")
    end  

    it "should not sign them up if no details are provided" do
      visit '/'
      within '#signup' do
        click_button 'Sign Up'
      end
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("Password is too short (minimum is 7 characters)")
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
    end  
  end

  describe "User logs in" do
    it "should log them in with valid details" do
      visit '/'
      within '#signup' do
        fill_in 'First Name', :with => "Tom"
        fill_in 'Last Name', :with => "Wissy"
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
        fill_in 'Password Confirmation', :with => "Password"
        click_button 'Sign Up'
      end
      within '#login' do
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
      end
      click_button 'Log In'
      expect(page).to have_content("This is your first log in!")
    end

    it "should not log them in with invalid details" do
      visit '/'
      within '#signup' do
        fill_in 'First Name', :with => "Tom"
        fill_in 'Last Name', :with => "Wissy"
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
        fill_in 'Password Confirmation', :with => "Password"
        click_button 'Sign Up'
      end
      within '#login' do
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Pissyword"
      end
      click_button 'Log In'
      expect(page).to have_content("Password and/or email incorrect.")
    end

    it "should increment the login count with each login" do
      visit '/'
      within '#signup' do
        fill_in 'First Name', :with => "Tom"
        fill_in 'Last Name', :with => "Wissy"
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
        fill_in 'Password Confirmation', :with => "Password"
        click_button 'Sign Up'
      end
      within '#login' do
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
      end
      click_button 'Log In'
      expect(page).to have_content("This is your first log in!")
      click_link 'Sign Out'
      within '#login' do
        fill_in 'Email', :with => "tom@gmail.com"
        fill_in 'Password', :with => "Password"
      end
      click_button 'Log In'
      expect(page).to have_content("Hello Tom! You have logged in 2 times")
    end
  end  
end
