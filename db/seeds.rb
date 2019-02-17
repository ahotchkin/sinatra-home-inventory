# Add seed data here. Seed your database with `rake db:seed`

current_user.categories << Category.create(name: "Kitchen")
current_user.categories << Category.create(name: "Living Room")
current_user.categories << Category.create(name: "Bedroom")
current_user.categories << Category.create(name: "Office")
current_user.categories << Category.create(name: "Electronics")
current_user.categories << Category.create(name: "Media")
current_user.categories << Category.create(name: "Appliances")
