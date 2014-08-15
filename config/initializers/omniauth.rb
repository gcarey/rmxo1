Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "37721039452-oi2gb2kequ6ljqtfs80u61dmthkfaffk.apps.googleusercontent.com", ENV["GOOGLE_CLIENT_SECRET"]
end