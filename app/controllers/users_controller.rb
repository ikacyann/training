class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}


  def ensure_correct_user
    if @current_user.id != params[:id].to_i
       flash[:notice] = "権限がありません"
       redirect_to("/users/index")
    end
  end




  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(name: params[:name],
                     email: params[:email],
                     password: params[:password]
                     )
    @user.image_name = "default_user.jpg"
    if @user.save
      session[:user_id] = @user.id
    flash[:notice] = "登録しました"
    redirect_to("/users/#{@user.id}")
    else
      render("home/top")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.password = params[:password]
    @user.profile = params[:profile]
    @user.pinned_tweet = params[:pinned_tweet]
    if params[:image]
       image = params[:image]
       @user.image_name = "#{@user.id}.jpg"
       File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if params[:background_image]
       background = params[:background_image]
       @user.background_image = "#{@user.id}.jpg"
       File.binwrite("public/background_images/#{@user.background_image}", background.read)
    end
    @user.save
    redirect_to("/users/#{@user.id}")
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name],
                         password: params[:password])
    if @user
       session[:user_id] = @user.id
       flash[:notice] = "ログインしました"
       redirect_to("/users/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
end
