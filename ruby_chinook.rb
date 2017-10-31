require 'sqlite3'

begin
# Connect to database
db = SQLite3::Database.open("Chinook_Sqlite.sqlite")

####### db.execute changes happen immediatley on the DB#######
    # call all albums from DB
    # albums = db.execute("select * from album;")
    # p albums

    # new_artist = db.execute("INSERT INTO artist (name) VALUES ('rickybobby');")
    # p new_artist

    # teresa = "Teresa"
    # db.execute("INSERT INTO artist (name) VALUES ('#{teresa}');")
    # teresa_id = db.last_insert_row_id
    # p teresa_id

    # all_teresas1 = db.execute "SELECT * FROM artist WHERE name = ?", teresa
    # all_teresas2 = db.execute "SELECT * FROM artist WHERE name = :teresa", teresa
    # all_teresas3 = db.execute "SELECT * FROM artist WHERE name = :teresa AND artistid = :teresa_id", teresa, 282
    # # OR
    # all_teresas4 = db.execute "SELECT * FROM artist WHERE name = ? AND artistid = ?", teresa, 284
    # p all_teresas2
    # p all_teresas3
    # p all_teresas4

##### db.prepare creates a SQL statement and holds in memory until execute command is run ######

    name = "Teresa"
    # SQL statment held 
    stm = db.prepare "SELECT * FROM artist WHERE name = ? AND artistid = ?" # Creates a SQL statement
    #stm.bind_param is saying bind the variable name where there is a ?
    stm.bind_param 1, name # passes name variable into name = ?
    stm.bind_param 2, 280 # passes artistid variable into artistid = ?
    p stm.class
    rs = stm.execute # stm is a variable that holds the sql statement
    p rs.class
    p.rs.columns
    p rs.next # rs variable holds what the sql returns when executed on the database

    stm.close # Closes the stm

    # --- Another Query ---
    db.transaction
    db.execute "CREATE TABLE concerts(concertId INTEGER PRIMARY KEY, venue TEXT)"
    db.EXECUTE "INSERT INTO concerts(venue) VALUES ('Ryman Auditiorium')"
    db.EXECUTE "INSERT INTO concerts(venue) VALUES ('Nissan Stadium')"
    db.commit


# Close Database
db.close if db # It is a good habit to close the db when done.

# db.close
rescue SQLite3::Exception => e
    p "Exception with DB query: #{e}"
    db.rollback # rollback transaction.  If query fails, rescue rolls back query.
end