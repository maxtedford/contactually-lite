require 'rails_helper'

describe WelcomeController do
  context '#index' do
    it 'displays the welcome page' do
      get :show

      expect(response).to have_http_status(:ok)
    end
  end
end

