require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/notes", type: :request do
  notes_count = rand(1..3)
  other_notes_count = rand(1..3)
  another_notes_count = rand(1..3)

  let!(:user) { create(:user) }
  let(:note_with_valid_attributes) { attributes_for(:note, :with_image) }
  let(:note_with_invalid_attributes) { attributes_for(:note, :invalid) }
  let!(:notes) { create_list(:note, notes_count, :with_all_attributes, user: user) }
  let!(:notes_other_user) { create_list(:note, other_notes_count, :with_all_attributes) }
  let!(:notes_another_user) { create_list(:note, another_notes_count, :with_all_attributes) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "GET /index" do
    subject(:get_index) { get notes_url }
    context "when successful" do
      before { get notes_url }

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "renders a successful response with correct notes" do
        expect(notes.count).to eq(controller.instance_variable_get(:@notes).count)
        notes.each do |note|
          expect(response.body).to include(note.title)
          expect(response.body).to include(note.image.filename.to_s)
          expect(response.body).to include(note.content.body.to_plain_text)
        end
      end
    end
  end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     note = Note.create! valid_attributes
  #     get note_url(note)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /edit" do
  #   it "renders a successful response" do
  #     note = Note.create! valid_attributes
  #     get edit_note_url(note)
  #     expect(response).to be_successful
  #   end
  # end

  describe "POST /create" do
    subject(:create_note) { post notes_url, params: {note: note_with_valid_attributes} }
    subject(:try_create_note) { post notes_url, params: {note: note_with_invalid_attributes} }

    context "with valid parameters" do
      it "returns a successful response" do
        create_note
        expect(response).to have_http_status(:created)
      end

      it "creates a new Note" do
        expect { create_note }.to change(Note, :count).by(1)
      end

      it "should have image attached" do
        create_note
        expect(controller.instance_variable_get(:@note).image.attached?).to be true
        ## test card added
      end
    end

    context "with invalid parameters" do
      it "returns a unsuccessful response" do
        try_create_note
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested note" do
  #       note = Note.create! valid_attributes
  #       patch note_url(note), params: {note: new_attributes}
  #       note.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the note" do
  #       note = Note.create! valid_attributes
  #       patch note_url(note), params: {note: new_attributes}
  #       note.reload
  #       expect(response).to redirect_to(note_url(note))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a response with 422 status (i.e. to display the 'edit' template)" do
  #       note = Note.create! valid_attributes
  #       patch note_url(note), params: {note: invalid_attributes}
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  describe "DELETE /destroy" do
    subject(:delete_note) { delete note_url(Note.order("RANDOM()").take) }

    context "everything ok" do
      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "destroys the requested note" do
        expect { delete_note }.to change(Note, :count).by(-1)
      end
    end
  end
end
