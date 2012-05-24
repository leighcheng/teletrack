class DociphoneController < ApplicationController
  before_filter :authorize    
  layout 'iphone'   
end
