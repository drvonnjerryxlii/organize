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
    only_note_params = extract_note_params
    @note = Note.new(only_note_params)

    if @note.save
      @note.update(note_params) # FIXME: error handling
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

    def extract_note_params
      only_note_params = note_params.deep_dup
      only_note_params.delete(:category_ids)
      only_note_params.delete(:categories_attributes)

      return only_note_params
    end

    def note_params
      params.require(:note).permit(
        :user_id,
        :note,
        :category_ids => [],
        :categories_attributes => [:id, :name]
      )
    end
end
