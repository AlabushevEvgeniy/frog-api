require 'rails_helper'

describe API::V1::Public::Registration, type: :request do
  describe 'POST /' do
    context 'when valid params' do
      let!(:photo) { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/avatar.jpg')) }
      let(:user) { attributes_for(:user, avatar: nil) }

      it 'creates new user' do
        expect{ post '/api/v1/registrations', params: { user: user } }
          .to change(User, :count).by(1)
      end
    end

    context 'when invalid params' do
      let(:user) { {email: nil} }

      it 'does not create new user' do
        expect{ post '/api/v1/registrations', params: { user: user } }
            .not_to change(User, :count)
      end
    end
  end
end
