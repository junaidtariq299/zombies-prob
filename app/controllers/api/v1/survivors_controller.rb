class Api::V1::SurvivorsController < ApplicationController

  before_action :set_survivor, only: [:update]

  def index
    @survivors = Survivor.all
    render json: @survivors
  end

  def create
    @survivor = Survivor.new survivor_params

    if @survivor.save
      render json: @survivor, head: :success
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def update
    if @survivor.update update_survivor_params
      render json: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory_items_attributes: [:id, :item_id, :quantity])
    end

    def update_survivor_params
      params.require(:survivor).permit(:latitude, :longitude)
    end
end
