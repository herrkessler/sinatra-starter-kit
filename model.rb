# -----------------------------------------------------------
# DataMapper Setup
# -----------------------------------------------------------

# DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 
DataMapper::setup(:default, "postgres:newApp")

# -----------------------------------------------------------
# Model and Associations
# -----------------------------------------------------------

require_relative "models/user"

# -----------------------------------------------------------
# DataMapper Finalization
# -----------------------------------------------------------

DataMapper.finalize
DataMapper.auto_upgrade!

# -----------------------------------------------------------
# Create Dummy Data
# -----------------------------------------------------------

if User.count == 0
  @user = User.new()
  @user.username = "admin"
  @user.email = "admin@app.com"
  @user.forename = "the ADMIN"
  @user.familyname = ""
  @user.admin = true
  @user.save
end