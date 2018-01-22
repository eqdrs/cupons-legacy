module Functions
  def transform_datetime(date)
    date.strftime('%d/%m/%Y %H:%M')
  end

  def login_user
    user = create(:user)

    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password

    click_on 'Log in'
    user
  end

  def t(string)
    I18n.t(string)
  end
end
