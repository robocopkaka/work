module SchoolsHelper
	  # this action pulls all the federal schools from the schools table
  def federal_schools
    #@lat_lng = cookies[:lat_lng].split("|")
   #@schools = School.near(@lat_lng, 10).where(classification: "Federal").paginate(page: params[:page], per_page:10) # to find federal schools near you
    @schools = School.where("classification=? AND approved=?", "Federal", true).paginate(page: params[:page], per_page:10)
  end

	 # this action pulls all the private schools from the schools table
  def private_schools
    #@lat_lng = cookies[:lat_lng].split("|")
    #@schools = School.near(@lat_lng, 10).where(classification: "Private").paginate(page: params[:page], per_page:10)
    @schools = School.where("classification=? AND approved=?", "Private", true).paginate(page: params[:page], per_page:10)
  end

  def state_schools
    @schools = School.where("classification=? AND approved=?", "State", true).paginate(page: params[:page], per_page:10)
  end

  def primary_schools
    @schools = School.where("category=? AND approved=?", "Primary", true).paginate(page: params[:page], per_page:10)
  end

  def secondary_schools
    @schools = School.where("category=? AND approved=?", "Secondary", true).paginate(page: params[:page], per_page:10)
  end

  def primary_and_secondary_schools
    @schools = School.where("category=? AND approved=?", "Primary&Secondary", true).paginate(page: params[:page], per_page:10)
  end

  def creches
    @schools = School.where("category=? AND approved=?", "Creche", true).paginate(page: params[:page], per_page:10)
  end

  def universities
    @schools = School.where("category=? AND approved=?", "University", true).paginate(page: params[:page], per_page:10)
  end   

end
