class NotesController < ApplicationController
  before_action :require_user
  before_action :set_note, only: [:edit, :update, :destroy]

  def index
    @notes = Note.where(user_id: current_user.id)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.validate_and_save
      flash[:notice] = "Note created"
      redirect_to notes_path
    else
      flash[:error] = "Note creation failed. See errors below"
      render :new
    end
  end

  def edit; end

  def update
    if @note.validate_and_update(note_params)
      flash[:notice] = "Note updated"
      redirect_to notes_path
    else
      flash[:error] = "Note update failed. See errors below"
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path, flash: { notice: "Note destroyed"}
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end