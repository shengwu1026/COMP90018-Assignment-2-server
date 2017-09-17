RSpec.shared_examples 'a resource controller' do
    # let!(:model) { create :user } # placeholder
    # let(:show_attr) { %w(id first_name last_name and username) }
    # let(:invalid_model_attributes) { {first_name:nil} }
    # let(:models) optional
    let(:model_sym) { model.model_name.name.underscore.downcase.to_sym }
    # let(:successful_create_params) {{ model_sym => model.attributes }}
    let(:successful_update_params) {{ id: model.id, model_sym => model.attributes }}
    let(:failed_update_params) { {id: model.id, model_sym => invalid_model_attributes} }

    describe 'GET index' do
        it 'renders all resources of this type' do
            get :index

            all_records = defined?(models) ? models : model.class.name.constantize.all
              # .map{|m|
              #   (show_attr + ['id']).map{|k| [k, m.send(k.to_sym)]}.to_h }

            expect(response.body).to be_json_eql(all_records.to_json)
        end
    end

    describe 'GET show' do
        it "renders a resource's details" do
            get :show, params: { id: model.id }

            expect(response.body).to be_json_eql(
                show_attr.map{|k| [k,model.send(k.to_sym)]}.to_h.to_json )
        end
    end

    describe 'POST create' do
        context 'successful create' do
            it "renders the created resource's details" do
                post :create, params: successful_create_params

                last_created_model = model.class.name.constantize
                    .order(created_at: :desc).first

                # raise last_created_model.inspect

                # get array of keys in string to compare with model attributes,
                # filter anything to do with password
                create_keys = successful_create_params[model_sym].keys
                    .map(&:to_s).reject{|k| k.eql? 'password'}

                successful_create_params[model_sym].reject!{|k| k.eql? :password}

                # check that attributes are exactly the same
                expect(last_created_model.attributes.select{|k,v| k.in? create_keys }.to_json)
                    .to be_json_eql(successful_create_params[model_sym].to_json)

                expect(response.body).to be_json_eql(
                    show_attr.map{|k| [k,last_created_model.send(k.to_sym)]}.to_h.to_json )
            end
        end
    end

    describe 'PATCH update' do
        context 'successful update' do
            # test for merged update
            # it 'merges previous jsonb field values with values to update' do
            #
            # end

            it 'returns http status 204' do
                patch :update, params: successful_update_params

                expect(response).to have_http_status(204)
            end
        end

        context 'failed update' do
            before do
                # raise failed_update_params.inspect
                patch :update, params: failed_update_params
            end

            it 'returns http status 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns error messages' do
                model.assign_attributes request.params[model_sym]
                model.valid?
                expect(response.body).to eq({errors: model.errors.full_messages}.to_json)
            end
        end
    end

    describe 'DELETE destroy' do
        it 'returns http status 204' do
            delete :destroy, params: { id: model.id }
            expect(response).to have_http_status(204)
        end
    end

    describe 'Record not found' do
        it 'returns http status 404 with error message' do
            get :show, params: { id: 'bogus-id' }
            expect(response).to have_http_status(404)
        end
    end
end
