require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/relationships/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/relationships/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
