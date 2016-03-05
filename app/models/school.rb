

class School < ActiveRecord::Base

	validates :name, presence:true, length: {minimum:5}
	validates :description, presence:true
	validates :address, presence:true
	validates :location, presence: true
	validates_uniqueness_of :name, scope: [:location, :category, :classification, :address], :message => "%{value}, with the same address, location and category has already been taken" #better than using .exists? and works on update method, basically checks that a record wwith the same school name, category, and location doesn't appear twice
	mount_uploader :picture, PictureUploader
	#validates :category, presence:true

	#scope :contains_name_or_location, -> (name) {where('school_name LIKE ? OR location LIKE ?', "%#{name}%", "#{name}")}
	scope :contains_name, -> (name) {where('name ILIKE ?', "%#{name}%")}
	#scope :contains_state, -> (state) {where('location LIKE ?', "%#{state}%")}
	#scope :contains_category, -> (category) {where('category LIKE ?', "#{category}")}
	scope :contains_name_and_state, -> (name) {where('name LIKE ? OR location LIKE ?', "%#{name}%" , "%#{name}")}
	#scope :contains_name_and_category, -> (name, category) {where('school_name LIKE ? AND category LIKE ?', "%#{name}%", "#{category}")}
	#scope :contains_state_and_category, -> (state, category) {where('location LIKE ? AND category like ?', "%#{state}%", "#{category}")}
	scope :contains_name_and_category_and_state, -> (name) {where('name LIKE ? OR location like ? OR category LIKE ?', "%#{name}%", "%#{name}%", "%#{name}")}
	scope :approved_status, -> (status) {where(approved: status)}
	scope :approved_true, -> {where(approved: true)}


	#searchkick word_start: [:school_name]

	CATEGORIES = ["Primary", "Secondary", "Primary&Secondary", "Creche", "University"]
	CLASSIFICATION = ["Federal", "State", "Private"]

	geocoded_by :the_address
	after_validation :geocode

	def the_address
		[address, location].compact.join(',') #.compact removes nil arguments/ members from the array
	end

    def self.search(search)
  		where("name like ?", "%#{search}%")
	end

	

end



