class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
      @user = current_user  
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
      @favorites = Favorite.where(first_id: current_user.id)
  end

  def list_conversations
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    respond_to do |format|
      format.js 
    end
  end

  def unread
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @messages = Message.where.not(("user_id = ? and read != ?"),current_user.id,nil)
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    respond_to do |format|
      format.js 
    end
  end

  def delete_dialog
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    respond_to do |format|
      format.js 
    end
  end 

def destroy_multiple
  Conversation.destroy(params[:conversations])
    respond_to do |format|
      format.html { redirect_to delete_path }
    end
end

  def show
  	@user = current_user
  end


  def edit
  		@user = current_user
  end


  def update
	  @user = current_user	
      if @user.update!(user_params)
        flash[:notice] = "User updated."
        redirect_to profile_path
      else
        flash[:error] = "Could not update user."
        render :edit
      end
  end

  def add_to_favorites
    user = User.find(params[:user])
    puts user.id
    current_user.favorite << user.id
    redirect_to controller: "users", action: "index"
  end



private
    def user_params
       params.require(:user).permit(:name, :picture, :age, :country, :city )
    end


end
