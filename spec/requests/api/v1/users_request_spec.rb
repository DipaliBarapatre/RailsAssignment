require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

	describe "GET /api/users" do
	  before do
         User.create(first_name: "test", last_name: "test", email: "test@email.com")
	  end

	  it "should return success" do
	  	get "/api/v1/users"
	  	expect(response).to have_http_status(:success)
	  end

	  it "should return all users" do
	    get "/api/v1/users"
	  	json_response = JSON.parse(response.body)
	  	expect(json_response.last.keys).to match_array(["created_at", "email", "first_name", "id", "last_name", "updated_at"])
	  end
    end

    describe "GET /api/users/1" do
	  before do
         User.create(first_name: "test", last_name: "test", email: "test@email.com")
         get "/api/v1/users/1"
	  end

	  it "should return success" do
	  	expect(response).to have_http_status(:success)
	  end

	  it "should return all users" do
	  	json_response = JSON.parse(response.body)
	  	expect(json_response.keys).to match_array(["created_at", "email", "first_name", "id", "last_name", "updated_at"])
	  end
    end

end
