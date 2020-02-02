class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]
  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже вошли' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже вошли' if current_user.present?
    
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: "Вы успешно зарегистрировались." 
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answered_questions_count = @questions.count(:answer)
    @unanswered_questions_count = @questions_count - @answered_questions_count
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Данные успешно обновлены." 
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Ваш аккаунт был удален."
  end

  private
  def authorize_user
    reject_user unless @user == current_user  
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :header_color)
  end
end
