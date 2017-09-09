require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::UsersController, type: :controller do
    let!(:model) { create :user }
    let(:models) { User.all.map{|u| u.attributes.reject{|k,v| k.eql? 'password_digest'} }}
    let(:show_attr) { %w(first_name last_name username) }
    let(:invalid_model_attributes) { {first_name:nil} }

    it_behaves_like 'a resource controller'
end
