class GadgetsController < ApplicationController
  before_action :set_gadget, only: [:show, :edit, :update, :destroy]

  def index
    @gadgets = Gadget.get_by current_user.to_param
  end

  def show
  end

  def new
    @gadget = Gadget.new
  end

  def edit
  end

  def create
    @gadget = Gadget.new(gadget_params)

    respond_to do |format|
      if @gadget.save
        format.html { redirect_to @gadget, notice: 'Gadget was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_gadget
    @gadget = Gadget.find(params[:id])
  end

  def gadget_params
    params.require(:gadget).permit(:name, :description, :user_id)
  end
end
