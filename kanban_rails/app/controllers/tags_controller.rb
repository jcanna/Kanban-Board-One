class TagsController < ApplicationController
  # GET /tags
  # GET /tags.XML
  def index
    @tags = Tag.find(:all, :include => :cards)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags.to_xml(:include => :cards) }
    end
  end

  # GET /tags/1
  # GET /tags/1.XML
  def show
    @tag = Tag.find(params[:id], :include => :cards)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag.to_xml(:include => :cards) }
    end
  end

  # GET /tags/new
  # GET /tags/new.XML
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.XML
  def create
    @cardId = params[:tag].fetch(:card_id)
    params[:tag].delete(:card_id)
    @tagName = params[:tag].fetch(:name)
    if ( @tagForName = Tag.find_by_name(@tagName, :include => :cards) )
      @tag = @tagForName
    else
      @tag = Tag.new(params[:tag])
    end
    if ( @card = Card.find(@cardId) )
      @tag.cards << @card
    end
    
    respond_to do |format|
      if @tag.save
        flash[:notice] = 'tag was successfully created.'
        format.xml  { render :xml => @tag.to_xml(:include => :cards) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.XML
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'tag was successfully updated.'
        format.html { redirect_to(@tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.XML
  def destroy
    @cardId = params[:tag].fetch(:card_id)
    @card = Card.find(@cardId)
    @tagId = params[:tag].fetch(:id)
    @tag = Tag.find(@tagId, :include => :cards)
    if @tag.cards.include?(@card)
      @tag.cards.delete(@card)
    end
    if @tag.cards.empty?
      @tag.destroy
    else
      @tag.save
    end
    
    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.XML  { head :ok }
    end
  end
end
