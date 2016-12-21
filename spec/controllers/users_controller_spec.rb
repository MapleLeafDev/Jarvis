require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      login_admin
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "redirects to user profile if not 'admin'" do
      user = create(:parent)

      login(user)
      get :index
      expect(response).to redirect_to(user_path(current_user))
    end

    it "renders the index template" do
      login_admin
      get :index
      expect(response).to render_template("index")
    end
  end
end
