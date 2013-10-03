enable :sessions

#======== GET ROUTES ===================

get '/' do
	if session[:user_id]
		@events = Event.all
		@user = User.find(session[:user_id])
		erb :index
	else
		redirect to "/login"
	end
end

get '/login' do
	if session[:user_id]
		redirect to "/"
	else
		erb :login
	end
end


get '/logout' do
	session.clear
	redirect to "/login"
end

# ======= POST ROUTES ==================

post '/login' do
	user = User.find_by_email(params[:email])
	if user && user.password == params[:password]
		session[:user_id] = user.id
		redirect to "/"
	else
		redirect to "/login"
	end
end

post '/signup' do
	user = User.new(params[:user])
	user.password = params[:password]

	if user.save
		session[:user_id] = user.id
		redirect to "/"
	else
		redirect to "/login"
	end
end