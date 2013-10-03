enable :sessions
# ====== GET ==================

get '/show_events' do
	if session[:user_id]
		@events = Event.order('updated_at DESC').all
		@users = User.all
		erb :show_events
	else
		redirect to "/login"
	end
end

get '/events/new' do
	if session[:user_id]
		erb :create_event
	else
		redirect to "/login"
	end
end

get '/events/:id/edit' do
	@event = Event.find(params[:id])
	erb :edit_event
end
#========= POST ==========

post '/events' do
	@user = User.find(session[:user_id])
	@user.created_events << Event.new(params[:event])
	redirect to "/"
end

post '/events/:id' do
	@event = Event.find(params[:id])
	if @event.update_attributes(params[:event])
		redirect to "/"
	else
		erb :edit_event
	end
end

post '/events/:id/attend' do
	event = Event.find(params[:id])
	user = User.find(session[:user_id])
	if user.attended_events.include?(event)
		redirect to "/"
	else
		user.attended_events << event
		redirect to "/"
	end
end

post '/events/:id/delete' do
	@event = Event.find(params[:id])
	@event.destroy
	redirect to "/"
end
