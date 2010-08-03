class ColumnsController < ApplicationController
  # GET /columns
  # GET /columns.xml
  def index
    @columns = Column.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @columns }
    end
  end

  # GET /columns/1
  # GET /columns/1.xml
  def show
    @column = Column.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @column }
    end
  end

  # GET /columns/new
  # GET /columns/new.xml
  def new
    @column = Column.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @column }
    end
  end

  # GET /columns/1/edit
  def edit
    @column = Column.find(params[:id])
  end

  # POST /columns
  # POST /columns.xml
  def create
    @column = Column.new(params[:column])
    position = @column.position;
    @column.position = nil;
    @column.save
    @column.remove_from_list()
    saveOkay = @column.insert_at(position)
      
    respond_to do |format|
      if saveOkay
        format.xml  { render :xml => @column.to_xml()}
      else
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /columns/1
  # PUT /columns/1.xml
  def update
    @column = Column.find(params[:id])

    params[:column].delete(:id)
    params[:column].delete(:cards)
    params[:column].delete(:updated_at)

    if params[:column][:position] == nil || @column.position.to_i == params[:column][:position].to_i
        params[:column].delete(:position)
        updateResult = @column.update_attributes(params[:column])
    else
        updateResult = @column.insert_at(params[:column][:position])
    end

    respond_to do |format|
      if updateResult
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /columns/1
  # DELETE /columns/1.xml
  def destroy
    @column = Column.find(params[:id])
    @column.remove_from_list()
    @column.destroy

    respond_to do |format|
      format.html { redirect_to(columns_url) }
      format.xml  { head :ok }
    end
  end
end
