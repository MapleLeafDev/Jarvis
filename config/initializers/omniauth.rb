OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, 'JVfaewA6vSBIbKkL74YkfrmLfbsBnwoItBnSEDEGYgzvQiPnU0', 'XLWZhgdcYAdYRbs6A3KjSDMhrcsygJkofKF5vHvWRYE5FsVIYE'
  provider :twitter, "bpRzFtxeqooYCBau5qFcz4LHG", "RDbEHYY19v2FXputsCpQCxwJmLWZiIUSWRCsTuqdBljQQcbhd7", { :authorize_params => { :force_login => 'true' }}
end
