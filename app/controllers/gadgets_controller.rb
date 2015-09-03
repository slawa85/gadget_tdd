class GadgetsController < ApplicationController
  before_action :set_gadget, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

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
    respond_to do |format|
      if @gadget.update(gadget_params)
        format.html { redirect_to @gadget, notice: 'Gadget was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @gadget.destroy
    respond_to do |format|
      format.html { redirect_to gadgets_url, notice: 'Gadget was successfully destroyed.' }
    end
  end

  def search
    @gadgets = Gadget.search(params[:q], current_user.to_param)
  end

  private

  def set_gadget
    @gadget = Gadget.find(params[:id])
  end

  def gadget_params
    params.require(:gadget).permit(:name, :description, :user_id, images_attributes: [:image])
  end
end
