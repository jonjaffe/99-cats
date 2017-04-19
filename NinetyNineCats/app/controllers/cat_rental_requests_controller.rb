class CatRentalRequestsController < ApplicationController

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    request = CatRentalRequest.new(cat_rental_request_params)
    if request.save
      redirect_to cat_rental_request_url(request)
    else
      redirect_to new_cat_rental_request_url
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
