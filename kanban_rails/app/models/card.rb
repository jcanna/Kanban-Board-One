class Card < ActiveRecord::Base
  before_save :remove_generated_attributes
  after_save :update_card_histories
  after_save :calculate_days_in_column
  after_find :calculate_days_in_column
  after_destroy :update_card_histories_on_destroy
    
  belongs_to :column
  acts_as_list :scope => :column
  has_many :card_histories
  has_and_belongs_to_many :tags, :uniq => true
  has_one :type
  has_one :user
   
  def update_card_histories 
    if (@changed_attributes.has_key?('column_id')) 
      if (@changed_attributes['column_id'] != nil)
        CardHistory.new(:column_id => @changed_attributes['column_id'],
                        :card_id => id,
                        :action => "left").save
      end
      
      CardHistory.new(:column_id => column_id,
                      :card_id => id, 
                      :action => "entered").save;
    end
  end
  
  def update_card_histories_on_destroy
    CardHistory.new(:column_id => column_id,
                    :card_id => id,
                    :action => "left").save
  end
  
  def remove_generated_attributes
    @attributes.delete('days_in_column')
  end
  
  def calculate_days_in_column
    @attributes['days_in_column'] = date_in_column.nil? ? '?' : ((Time.now - date_in_column)/(60*60*24)).round
  end
  
  def after_find 
    # this is necessary so that active record will call the 
    # registared call back for after_find
  end

end
