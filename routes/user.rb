class App < Sinatra::Base

  # User
  # -----------------------------------------------------------

  #  Index
  get '/users' do
    @users = User.all(:order => [:username.asc]).paginate(:page => params[:page], :per_page => 100)
    slim :"user/index"
  end

  #  New User
  get '/users/new' do
    @user = User.new
    slim :"user/new"
  end

  post '/users' do

    data = params[:user]
    @user = User.create(data)

    if @user.saved?

      # Redirect to login
      flash[:new_user] = 'Hallo ' + @user.forename + ', du kannst Dich nun einloggen'
      redirect to("/auth/login")

    else

      flash[:error] = 'Something went wrong while signing up'
      redirect to("/users/new")

    end
  end

  # Show
  get '/users/:id' do
    @user = User.get(params[:id])
    # Render View

    if @user != nil
      slim :"user/show"
    else
      flash[:error] = 'What you are looking for does not exist'
      redirect to("/")
    end
  end

  # Edit
  get '/users/:id/edit' do
    @user = User.get(params[:id])
    slim :"user/edit"
  end

  put '/users/:id' do
    user = User.get(params[:id])
    user.update(params[:user])
    if user.saved?
      flash[:success] = 'User update successful'
      redirect to("/users/#{user.id}")
    else
      flash[:error] = 'Something went wrong'
      redirect to("/users/#{user.id}/edit")
    end
  end

  # Delete
  delete '/users/:id' do
    User.get(params[:id]).destroy
    redirect to('/')
  end

end