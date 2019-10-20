class WelcomeController < ApplicationController
  def index
    flash[:warning] = "小心！"
  end
end
