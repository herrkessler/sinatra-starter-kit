class User
  include DataMapper::Resource
  include Gravatarify::Helper

  property :id, Serial, :key => true
  property :forename , String
  property :familyname , String, :lazy => [ :show ]
  property :username, String, :length => 3..50, :required => true, :unique => true, :lazy => [ :show ]
  property :email, String, :format => :email_address, :required => true, :unique => true, :lazy => [ :show ]
  property :admin, Boolean, :default  => false, :lazy => [ :show ]
  property :gravatarURL, URI

  property :created_at, DateTime, :lazy => [ :show ]
  property :update_at, DateTime, :lazy => [ :show ]

  before :save, :gravatar

  def gravatar
    self.gravatarURL = gravatar_url(self, :size => 200, :default => 'retro', :secure => true)
  end

end