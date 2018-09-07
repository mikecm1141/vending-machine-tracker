class MachinesController < ApplicationController
  def index
    @owner = Owner.find(params[:owner_id])
  end

  def show
    @machine               = Machine.find(params[:id])
    @snacks                = @machine.snacks
    @machine_price_average = @machine.average_snack_price
  end
end
