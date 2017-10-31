require 'sqlite3'

# Connect to database
db = SQLite3::Database.new("Chinook_Sqlite.sqlite")

# #Do query
albums = db.execute("select * from album;")
p albums.class #print to terminal
p albums
 
# # Another Query
# country_most_money = db.execute("select BillingCountry, max(SalesTotal) from (select distinct BillingCountry, round(sum(Total), 2) as 'SalesTotal' from Invoice group by BillingCountry);")
# p country_most_money

# new_artist = db.execute("Insert Into artist (name) Values ('rickybobby');")
# p new_artist

#add to table
# artist_named_rickybobby = "RickyBobby"
# db.execute("Insert Into artist (name) VALUES ('#{artist_named_rickybobby}')")

# dan_id = db.last_insert_row_id
# p rickybobby_id

# an_id = 277

# all_rickybobby = db.execute "SELECT * FROM artist WHERE name = :artist AND ArtistId = :an_id", artist_named_rickybobby, an_id
# p all_rickybobby

# db.close

# rescue SQLite3::Exception => e
#   p "Exception with Database query : #{e}"
# end