class CardHistoriesController < ApplicationController
  # GET /card_histories
  # GET /card_histories.xml
  def index
    @card_histories = CardHistory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @card_histories }
    end
  end

  # GET /card_histories/1
  # GET /card_histories/1.xml
  def show
    @card_histories = CardHistory.find_all_by_card_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @card_histories.to_xml() }
    end
  end

  # GET /card_histories/new
  # GET /card_histories/new.xml
  def new
    @card_history = CardHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @card_history }
    end
  end

  # GET /card_histories/1/edit
  def edit
    @card_history = CardHistory.find(params[:id])
  end

  # POST /card_histories
  # POST /card_histories.xml
  def create
    @card_history = CardHistory.new(params[:card_history])

    respond_to do |format|
      if @card_history.save
        flash[:notice] = 'card_history was successfully created.'
        format.html { redirect_to(@card_history) }
        format.xml  { render :xml => @card_history, :status => :created, :location => @card_history }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @card_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /card_histories/1
  # PUT /card_histories/1.xml
  def update
    @card_history = CardHistory.find(params[:id])

    respond_to do |format|
      if @card_history.update_attributes(params[:card_history])
        flash[:notice] = 'card_history was successfully updated.'
        format.html { redirect_to(@card_history) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @card_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /card_histories/1
  # DELETE /card_histories/1.xml
  def destroy
    @card_history = CardHistory.find(params[:id])
    @card_history.destroy

    respond_to do |format|
      format.html { redirect_to(card_histories_url) }
      format.xml  { head :ok }
    end
  end
end
