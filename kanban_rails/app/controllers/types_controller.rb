class TypesController < ApplicationController
  # GET /types
  # GET /types.xml
  def index
    if ( @boardId = params[:board_id] )
      @types = Type.find_all_by_board_id(@boardId)
    else
      @types = Type.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @types.to_xml() }
    end
  end

  # GET /types/1
  # GET /types/1.xml
  def show
    @type = Type.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/new
  # GET /types/new.xml
  def new
    @type = Type.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/1/edit
  def edit
    @type = Type.find(params[:id])
  end

  # POST /types
  # POST /types.xml
  def create
    @type = Type.new(params[:type])

    respond_to do |format|
      if @type.save
        format.xml  { render :xml => @type.to_xml()}
      else
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /types/1
  # PUT /types/1.xml
  def update
    @type = Type.find(params[:id])
    params[:type].delete(:created_at)
    params[:type].delete(:updated_at)
    params[:type].delete(:mx_internal_uid)

    respond_to do |format|
      if @type.update_attributes(params[:type])
        flash[:notice] = 'Type was successfully updated.'
        format.xml  { render :xml => @type.to_xml() }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.xml
  def destroy
    @type = Type.find(params[:id])
    @type.destroy

    respond_to do |format|
      format.html { redirect_to(types_url) }
      format.xml  { head :ok }
    end
  end
end

