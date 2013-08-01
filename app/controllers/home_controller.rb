class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => ['index']

  def index

    if !user_signed_in?
      redirect_to new_user_session_path
      return
    end
    if (!current_user || !current_user.description)
      redirect_to :controller=>'descriptions', :action => 'new'
      return
    end

    @courses = Course.find :all, :order => 'id DESC', :limit => 6
  end

end
