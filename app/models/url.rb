class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	before_create :shorten, :counter
	validates :long_url, presence: true, uniqueness: true, format: { with: /https?:\/\/[\S]+/}
	

	def shorten
		range = [*'0'..'9',*'A'..'Z',*'a'..'z']
		@short_url = (0...7).map{ range.sample }.join
		self.short_url = @short_url
	end

	def counter
		self.click_count = 0
	end

end