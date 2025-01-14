class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      return render :new
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      return redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      return render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      return redirect_to root_path
    else
      if work.destroy
        flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      else
        flash.now[:error] = "A problem occurred: Could not delete #{work.category} #{work.id}"
      end
      return redirect_to root_path
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
