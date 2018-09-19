puts "seeding data"

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do
  |seed|
    load seed
  end

puts "seeding complete."
