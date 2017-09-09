RSpec.shared_examples 'a resource controller' do
    # let!(:model) { create :user } # placeholder
    # let(:show_attr) { %w(id first_name last_name and username) }
    # let(:invalid_model_attributes) { {first_name:nil} }
    let(:model_sym) { model.model_name.name.underscore.downcase.to_sym }
    let(:successful_update_params) {{ id: model.id, model_sym => model.attributes }}
    let(:failed_update_params) { {id: model.id, model_sym => invalid_model_attributes} }

    describe 'GET show' do
        it "renders a resource's details" do
            get :show, params: { id: model.id }

            expect(response.body).to be_json_eql(
                show_attr.map{|k| [k,model.send(k.to_sym)]}.to_h.to_json )
        end
    end

    describe 'GET update' do
        context 'successful update' do
            it 'returns http status 204' do
                patch :update, params: successful_update_params

                expect(response).to have_http_status(204)
            end
        end

        context 'failed update' do
            before do
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
