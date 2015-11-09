#go to the person page of some one
get '/users/:username' do
  logged_username = session[:username]
  logged_id = User.find_by(username: logged_username).id
  
  look_at_username = params[:username]
  look_at_user_id = User.find_by(username: look_at_username).id
  
  @parameters = user_a_look_at_user_b_homepage(logged_id, look_at_user_id)
  erb :personpage
end

post '/create/user' do
  user_checked = check(params)
  if user_checked.class == String
    redirect '/signup'
  end
  @user = User.new(user_checked)
  if @user.save
    response["successfully_sign_up"] = "true"
    redirect '/signin'
  end
end

post '/delete/user/:username' do
  user = User.find_by(username: params[:username])
  if user != nil
    user.destroy
    response["successfully_deleted"] = "true"
  end
  
end