OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, 'JVfaewA6vSBIbKkL74YkfrmLfbsBnwoItBnSEDEGYgzvQiPnU0', 'XLWZhgdcYAdYRbs6A3KjSDMhrcsygJkofKF5vHvWRYE5FsVIYE'
end