class SchoolAdminsController < ApplicationController
    def index
  	@user = User.find_by(id: params[:id])
  	if current_user.admin?
  		@schools = School.all.paginate(page: params[:page], per_page: 10)
  	else
  		redirect_to root_url
  	end
  end

  def approve
  	@school = School.find_by(id: params[:id])

  	if @school.approved?
  		@school.update_attributes(approved: false)
  		redirect_to :back #refreshes the page
  	else
  		@school.update_attributes(approved: true)
  		redirect_to :back
  	end
  end

   def destroy
    School.find(params[:id]).destroy
    flash[:success] = "School deleted successfully"
    redirect_back_or(school)
  end

  private

  #confirms an admin user
  def admin_user
  	redirect_to(root_url) unless current_user.admin?		
  end
end
