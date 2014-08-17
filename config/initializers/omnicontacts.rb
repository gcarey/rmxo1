require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {:redirect_path => "/findfriends", :ssl_ca_file => "/etc/ssl/certs/curl-ca-bundle.crt"}
end
