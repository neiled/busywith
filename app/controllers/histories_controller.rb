class HistoriesController < ApplicationController

  def show
    @user = User.find_by_login(params[:login])
    @history = History.find_by_user_id(@user.id, :limit => 20, :order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.rss # Add this line so we can respond in RSS format.
    end
  end


end
