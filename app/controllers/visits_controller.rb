class VisitsController < ApplicationController
  # A callback to set up an @visit object to work with 
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  def index
    # get all visits in reverse chronological order, 10 per page
    @visits = Visit.chronological.paginate(page: params[:page]).per_page(10)
  end
  
  def show
    # get all the vaccinations associated with this visit, if any
    @vaccinations = @visit.vaccinations
  end
  
  def new
    @visit = Visit.new
  end
  
  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      flash[:notice] = "Successfully added visit for #{@visit.pet.name}."
      redirect_to @visit
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @visit.update_attributes(visit_params)
      flash[:notice] = "Successfully updated visit by #{@visit.pet.name}."
      redirect_to @visit
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @visit.destroy
    flash[:notice] = "Successfully removed the visit of #{@visit.pet.name} on #{@visit.date.strftime('%b %e')}."
    redirect_to visits_url
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:pet_id, :date, :weight, :notes)
    end
end
