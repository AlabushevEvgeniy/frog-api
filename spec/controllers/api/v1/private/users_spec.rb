require 'rails_helper'

describe API::V1::Private::User, type: :request do

  describe 'GET /me' do
    let!(:user) { create :user }
    let(:path) {'/api/v1/users/me'}

    context 'Autheticated user' do
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }

      it 'returns current_user model' do
        get path, params: { access_token: access_token.token }
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to be_json_eql(user.id).at_path('id')
          expect(response.body).to be_json_eql(user.email.to_json).at_path('email')
          expect(response.body).to be_json_eql(user.avatar.to_json).at_path('avatar')
        end
      end
    end

    context 'Unauthenticated user' do
      it 'returns 401 status' do
        get path
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let(:path) {'/api/v1/users'}

    context 'Authenticated user' do
      let!(:access_token) { create(:access_token, resource_owner_id: user1.id) }

      it 'returns all users list' do
        get path, params: {access_token: access_token.token }
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to have_json_size(2)
        end
      end
    end

    context 'Unauthenticated user' do
      it 'returns 401 status' do
        get path
        expect(response).to have_http_status(401)
      end
    end
  end

  describe  'GET /:id' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }

    context 'Authenticated user' do
      let!(:access_token) { create(:access_token, resource_owner_id: user1.id) }

      it 'returns user by :id' do
        get "/api/v1/users/#{user2.id}", params: { access_token: access_token.token }
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to be_json_eql(user2.id).at_path('id')
        end
      end
    end

    context 'Unauthenticated user' do
      it 'returns 401 status' do
        get "/api/v1/users/#{user2.id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /update' do
    let!(:user) { create :user }
    let!(:new_name) { 'New name' }
    let!(:new_email) { 'new_email@example.com' }
    let(:path) { '/api/v1/users/update' }

    context 'Authenticated user' do
      let!(:access_token) { create(:access_token, resource_owner_id: user.id) }

      it 'updates current user' do
        put path, params: { access_token: access_token.token, user: {name: new_name, email: new_email} }
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to be_json_eql(new_name.to_json).at_path('name')
          expect(response.body).to be_json_eql(new_email.to_json).at_path('email')
        end
      end
    end

    context 'Unauthenticated' do
      it 'returns 401 status' do
        get path
        expect(response).to have_http_status(401)
      end
    end
  end
end
