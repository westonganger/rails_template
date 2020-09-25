if User.all.empty?
  user = User.new(
    email: SITE_DATA[:admin_user][:email], 
    password: SITE_DATA[:admin_user][:password], 
    password_confirmation: SITE_DATA[:admin_user][:password],
    invitation_accepted_at: Time.now,
    first_name: "John",
    last_name: "Smith",
  )

  user.save!

  user.add_role(:admin)
end
