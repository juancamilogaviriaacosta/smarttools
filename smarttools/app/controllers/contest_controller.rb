class ContestController < ApplicationController
  def manage
  	@admins = Administrator.all
  	@contests = Contest.all
 end
end
