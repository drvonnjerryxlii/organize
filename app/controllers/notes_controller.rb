class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [] # FIXME: why it not work before?

  def index
    @notes = Note.all
  end

  def show; end

  def new
    @note = Note.new
  end

  def edit; end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to @note
    else
      render :new
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:user_id, :note)
    end
end
