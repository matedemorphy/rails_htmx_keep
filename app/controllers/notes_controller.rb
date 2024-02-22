class NotesController < ApplicationController
  respond_to :html
  before_action :set_note, only: %i[show edit update destroy]

  # GET /notes
  def index
    @notes = Note.current_user(current_user.id).with_rich_text_content.with_attached_image
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
    render partial: 'notes/form', locals: { note: @note }
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      render partial: 'notes/note', locals: { note: @note }, status: :created
    else
      render partial: 'shared/form_errors', locals: { errors: @note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :image, :content).merge(user_id: current_user.id)
  end
end
