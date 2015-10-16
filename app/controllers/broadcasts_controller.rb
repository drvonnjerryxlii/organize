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
    @broadcast = Broadcast.new(broadcast_params)

    if @broadcast.save
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

    def broadcast_params
      params.require(:broadcast).permit(:title, :description)
    end
end
