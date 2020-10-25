class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  before_action :set_current_user, except: [:show]

  # GET /users/1
  def show
    @user = User.find(params[:id])

    @user_past_events = []
    @user_upcoming_events = []

    @user.events.all.each do |item|
      if item.datetime < Time.now
        @user_past_events << item
      else
        @user_upcoming_events << item
      end
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.t('controllers.users.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
