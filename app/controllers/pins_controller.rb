class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  respond_to :html

  def index
    @pins = Pin.all.order created_at: :desc
    # respond_with(@pins)
  end

  def show
    # respond_with(@pin)
  end

  def new
    @pin = current_user.pins.build
    # respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: "Pin was successfully created."
    else
      render :edit
    end
    # respond_with(@pin)
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin was successfully updated."
    else
      render :edit
    end
    # respond_with(@pin)
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
    # respond_with(@pin)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find_by(id: params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not Authorized to Edit this Pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
