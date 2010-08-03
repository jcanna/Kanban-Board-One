class Column < ActiveRecord::Base
  after_find    :calculate_average_days_in_column
  after_destroy :update_card_histories_on_destroy
  
  has_many :cards, :order => "position"
  has_many :card_histories
  belongs_to :board
  acts_as_list :scope => :board

  def update_card_histories_on_destroy
    @card_histories = CardHistory.find_all_by_column_id(@attributes['id'])
    @card_histories.each do |card_history|
      card_history.destroy
    end
  end
  
  def calculate_average_days_in_column
    if (Time.now - updated_at) > (60*60*24)
      @column_histories = CardHistory.find_all_by_column_id( id )
      return if @column_histories.nil? || @column_histories.empty?
      @departed = Array.new
      @entered = Array.new
      @column_histories.each do |column_history|      
        column_history.action == 'left' ? @departed << column_history : @entered << column_history
      end
      @differences = Array.new
      @entered.each do |enter_history|               
        @departed.each do |departed_history|
          if enter_history.card_id == departed_history.card_id && enter_history.created_at < departed_history.created_at
            @differences << departed_history.created_at - enter_history.created_at
            @departed.delete(departed_history)
          end
        end
      end
      @total_cards_time_in_column = 0.0
      @differences.each do |difference|              
        @total_cards_time_in_column += difference
      end
      if @differences.size > 0
        @attributes['new_average_days_in_column'] = ((@total_cards_time_in_column / @differences.size) / (60*60*24)).round
        @attributes['needs_saving'] = 'Y'
      end
    end
  end
  
  def after_find 
    # this is necessary so that active record will call the 
    # registared call back for after_find
  end
  
end
