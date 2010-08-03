class BoardsController < ApplicationController
  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.find(:all)
    respond_to do |format|
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    if ( params[:history] == nil )
      @board = Board.find(params[:id], :include => [{:columns => :cards}, :types])
      @board.columns.each do |column| # Update column for average_days_in_column recalc
        if defined? column.needs_saving == "Y"
          Column.update(column.id, :average_days_in_column => column.new_average_days_in_column)
          column.average_days_in_column = column.new_average_days_in_column
        end
      end
      respond_to do |format|
        format.xml  { render :xml => @board.to_xml(:include => { :types => {}, :columns => {:include => :cards}} ) }
      end
    else
      @board = Board.find(params[:id], :include => [{:columns => :card_histories}])
      respond_to do |format|
        format.xml  { render :xml => @board.to_xml(:include => { :columns => {:include => :card_histories}} ) }
      end
    end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @board = Board.new

    respond_to do |format|
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.xml
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        format.xml  { render :xml => @board.to_xml(:include => :columns) }
      else
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @board = Board.find(params[:id])

    params[:board].delete(:id)
    params[:board].delete(:columns)
    params[:board].delete(:types)
    params[:board].delete(:created_at)
    params[:board].delete(:updated_at)
    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.xml  { render :xml => @board.to_xml(:include => :columns) }
      else
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.xml
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
