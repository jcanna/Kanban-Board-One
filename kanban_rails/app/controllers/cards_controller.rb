

class CardsController < ApplicationController
  # GET /cards
  # GET /cards.xml
  def index
    @cards = Card.find(:all)
    respond_to do |format|
      format.xml  { render :xml => @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.xml
  def show
    @card = Card.find(params[:id], :include => :tags)

    respond_to do |format|
      format.xml  { render :xml => @card.to_xml(:include => :tags) }
    end
  end

  # GET /cards/new
  # GET /cards/new.xml
  def new
    @cards = Card.new

    respond_to do |format|
      format.xml  { render :xml => @cards }
    end
  end

  # GET /cards/1/edit
  def edit
    @cards = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.xml
  def create
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        format.xml  { render :xml => @card.to_xml() }
      else
        format.xml  { render :xml => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.xml
  def update
    @card = Card.find(params[:id])
    
    column = Column.find(@card.column_id)
#    card_original_board = column.board_id
      
    params[:card].delete(:id)
    params[:card].delete(:tags)
    params[:card].delete(:updated_at)
    params[:card].delete(:days_in_column)

    if @card.position.to_i != params[:card][:position].to_i ||
       (@card.column_id.to_i != params[:card][:column_id].to_i && params[:card][:column_id].to_i != 0)

      ActiveRecord::Base.partial_updates = false
      positionInList = params[:card][:position]
      params[:card].delete(:position)
      @card.remove_from_list()
      if (@card.column_id.to_i != params[:card][:column_id].to_i && params[:card][:column_id].to_i != 0)
        params[:card][:date_in_column] = Time.now
      end
      updateResult = @card.update_attributes(params[:card])
      @card.insert_at(positionInList)
    else
      params[:card].delete(:position)
      updateResult = @card.update_attributes(params[:card])
    end

    respond_to do |format|
      if updateResult
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @cards.errors, :status => :unprocessable_entity }
      end
    end

  end

  # DELETE /cards/1
  # DELETE /cards/1.xml
  def destroy
    @card = Card.find(params[:id])
    @card.remove_from_list()
    @card.destroy

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
