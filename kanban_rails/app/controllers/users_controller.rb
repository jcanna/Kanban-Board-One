class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  # Check if id is numeric, if not, use mud_id search instead
  def show
    if (params[:id].to_i.to_s == params[:id])
      @user = User.find(params[:id], :include => [:boards, :tags])
    else
      @user = User.find_by_mud_id(params[:id], :include => [:boards, :tags])
    end
    respond_to do |format|
      format.xml  { render :xml => @user.to_xml(:include => { :boards => {}, :tags => {}} ) }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.xml  { render :xml => @user.to_xml()}
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    params[:user].delete(:created_at)
    params[:user].delete(:updated_at)
    params[:user].delete(:mx_internal_uid)

    @updateAction = params[:user].fetch(:updateAction)
    if (@updateAction == 'updateProfile')
      params[:user].delete(:tags)
      params[:user].delete(:boards)
      params[:user].delete(:updateAction)
      updateResult = @user.update_attributes(params[:user])
    else
      if (@updateAction == 'addBoard')
        @user.boards << Board.find(params[:user].fetch(:board_id))
      end
      if (@updateAction == 'removeBoards')
        @boards = Board.find_all_by_id( params[:user].fetch(:board_ids).split(/,/) )
        @user.boards.delete( @boards )
      end
      if (@updateAction == 'addTag')
        @user.tags << Tag.find(params[:user].fetch(:tag_id))
      end
      if (@updateAction == 'removeTags')
        @tags = Tag.find_all_by_id( params[:user].fetch(:tag_ids).split(/,/) )
        @user.tags.delete( @tags )
      end
      updateResult = @user.save      
    end
    
    respond_to do |format|
      if updateResult
        flash[:notice] = 'User was successfully updated.'
        format.xml  { render :xml => @user.to_xml(:include => { :boards => {}, :tags => {}}) }
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
#    @user.boards.clear
#    @user.tags.clear
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
