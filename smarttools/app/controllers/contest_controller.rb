class ContestController < ApplicationController
  def manage
  	@admins = Administrator.all
  end
end
