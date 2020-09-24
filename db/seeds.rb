if User.exists?
  User.find_or_create_by!(email: 'admin@example.com', password: 'admin123', password_confirmation: 'admin123')
end
