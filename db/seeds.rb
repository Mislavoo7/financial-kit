Admin.create(
  email: "kvesic.mislav@gmail.com",
  password: "9233183a",
)
puts "++++ Admin Seeded"

require_relative "seed_methods/seed_pages"
require_relative "seed_methods/seed_legal_pages"

seed_home
puts "++++ Home Page Seeded"
seed_about
puts "++++ About Page Seeded"

seed_legal_pages
puts "++++ Legal pages Seeded"
