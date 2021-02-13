module LoginModule
  def sign_go(user)
    session_params = { session: { email: user.email, password: user.password }}
    post "/login", params: session_params
  end
end
