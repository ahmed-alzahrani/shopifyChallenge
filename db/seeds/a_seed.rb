puts "Beginning the a_seed (deletion)"

=begin
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  # MySQL and PostgreSQL
  # ActiveRecord::Base.connection.execute("TRUNCATE #{table}")

  # SQLite
  ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
end
=end

Store.delete_all
User.delete_all
Order.delete_all
Product.delete_all
Item.delete_all


puts "Finished the a_seed (deletion)"
