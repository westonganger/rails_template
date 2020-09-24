if User.all.empty?
  User.create!(
    email: SITE_DATA[:admin_user][:email], 
    password: SITE_DATA[:admin_user][:password], 
    password_confirmation: SITE_DATA[:admin_user][:password],
    invitation_accepted_at: Time.now,
  )
end
