class JqueryfiletreeController < ApplicationController
  protect_from_forgery :only => []
  def content
    @parent = params[:dir]
    @dir = Jqueryfiletree.new(@parent + 'app/assets/docs/').get_content
  end
end