OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, ENV['TUMBLR_ID'], ENV['TUMBLR_SECRET']
  provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET'], { :authorize_params => { :force_login => 'true' }}
end
