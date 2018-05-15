require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context 'with invalid params' do
      post :create, params: {user: { username: 'U1', password: 'abcdef'}}
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

  context 'with valid params' do
    post :create, params: {user: { username: 'U1', password: 'abcdef'}}
    expect(response).to redirect_to(new_session_url)
    end
  end
end
