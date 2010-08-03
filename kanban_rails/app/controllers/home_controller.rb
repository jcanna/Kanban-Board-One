class HomeController < ApplicationController 
  def index
    foo = url_for(:controller => "home")
    foo.slice!(/\/[a-zA-Z]*$/);
    foo = foo + "/";
    @home = Home.new(foo, params[:board_id],params[:card_id],params[:user_id])

  end
end