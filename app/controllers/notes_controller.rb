class NotesController < ApplicationController
  respond_to :html
  before_action :current_user_notes, only: %i[index search]
  before_action :set_note, only: %i[show edit update destroy color]
  before_action :set_target, only: %i[edit new]
  before_action :set_swap, only: %i[edit new]

  # GET /notes
  def index
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
    render partial: "notes/form", locals: {note: @note, target: @target, swap: @swap}
  end

  # GET /notes/1/edit
  def edit
    render partial: "notes/form", locals: {note: @note, target: @target, swap: @swap}
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      render partial: "notes/note", locals: {note: @note}, status: :created
    else
      render partial: "shared/form_errors", locals: {errors: @note.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render partial: "notes/note", locals: {note: @note}, status: :ok
    else
      render partial: "shared/form_errors", locals: {errors: @note.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def color
    if @note.update(color: params[:color].html_safe)
      render partial: "notes/note", locals: {note: @note}, status: :ok
    end
  end

  def search
    @notes = params[:search].blank? ? @notes : @notes.search_full_text(params[:search]&.strip)
    render partial: "notes/notes_grid", status: :ok
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

  def set_target
    @target = @note ? "#note_#{@note.id}" : "#notes-grid"
  end

  def set_swap
    @swap = @note ? "outerHTML" : "beforeend"
  end

  def current_user_notes
    @notes = Note.current_user(current_user.id).with_rich_text_content.with_attached_image
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :image, :content).merge(user_id: current_user.id)
  end
end
