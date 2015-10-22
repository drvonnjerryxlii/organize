class BroadcastsController < ApplicationController
  before_action :set_broadcast, only: [:show, :edit, :update, :destroy]

  def index
    @broadcasts = Broadcast.all
  end

  def show; end

  def new
    @broadcast = Broadcast.new
  end

  def edit; end

  def create
    only_broadcast_params = extract_broadcast_params
    @broadcast = Broadcast.new(only_broadcast_params)

    if @broadcast.save
      @broadcast.update(broadcast_params) # FIXME: error handling
      redirect_to @broadcast
    else
      render :new
    end
  end

  def update
    if @broadcast.update(broadcast_params)
      redirect_to @broadcast
    else
      render :edit
    end
  end

  def destroy
    @broadcast.destroy
    redirect_to broadcasts_url
  end

  private
    def set_broadcast
      @broadcast = Broadcast.find(params[:id])
    end

    def extract_broadcast_params
      only_broadcast_params = broadcast_params.deep_dup
      only_broadcast_params.delete(:category_ids)
      only_broadcast_params.delete(:categories_attributes)

      return only_broadcast_params
    end

    def broadcast_params
      params.require(:broadcast).permit(
        :title,
        :description,
        :active,
        :category_ids => [],
        :categories_attributes => [:id, :name]
      )
    end
end
