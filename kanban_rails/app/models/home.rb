class Home
  attr :kanbanURL
  attr :board_id
  attr :card_id
  attr :user_id
  attr :flash_vars
  
  def initialize(url,board,card,user)
    @kanbanURL = url
    @board_id  = board
    @card_id   = card
    @user_id   = user
  end
   
  def getFlashVars()
    flash_vars = "kanbanServer=" + @kanbanURL
    if (@board_id != nil)
      flash_vars += "&board_id=" + @board_id
    end
    if (@card_id != nil)
      flash_vars += "&card_id=" + @card_id
    end
    if (@user_id != nil)
      flash_vars += "&user_id=" + @user_id
    end
    return flash_vars;
  end

end
