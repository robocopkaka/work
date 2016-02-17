#School.create!(school_name: "kachi", school_address: "somewhere", school_description: "stuff", location: "yaba", category:"Secondary", classification:"Federal", approved:true)

#seed the schools table with randomly generated data using the faker gem
50.times do |n|
	school_name = Faker::University.name
	school_address = ["sabo", "egbeda"].sample
	school_location = "lagos"
	school_description = Faker::Lorem.sentence(10)
	school_website = Faker::Internet.url('schools.com')
	school_classifications = ["Federal", "State", "Private"].sample
	school_categories = ["Primary", "Secondary", "Primary&Secondary", "Creche", "University"].sample

	School.create!(name: school_name, address: school_address, description: school_description, location: school_location, website: school_website, classification: school_classifications, category: school_categories, approved:false)
end


#seed the users table with data
1.times do |n|
	User.create!(name: "kachi", email:"robocopkaka@gmail.com", password:"robocop", password_confirmation:"robocop", admin:true)
end