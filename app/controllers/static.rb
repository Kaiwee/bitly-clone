get '/' do
	@urls = Url.last(10)
	@urls.reverse!
	erb :"static/index"
end


post '/submit-post' do
	@url = Url.new(long_url: params["user-input"])
	if @url.save
		@url.to_json
	else
		status 404
		@url.errors.full_messages
		if params["user-input"].blank?
			{error_message: "Please enter a URL!"}.to_json
		else
			@url = Url.find_by(long_url: params["user-input"])
			if @url.nil?

				{error_message: "Invalid URL format!"}.to_json
			else
				{error_message: "This URL has already been taken!"}.to_json
			end

		end
	end

end


get '/:short_url' do
	@url = Url.find_by(short_url: params[:short_url])
	@url.click_count += 1
	@url.save
	
	redirect "#{@url.long_url}"
end