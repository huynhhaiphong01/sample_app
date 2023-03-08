class PartialsController < ApplicationController
  def new
    @zone = "Zone New action"
    @date = Date.today  
  end
  def edit
    @zone = "Zone Edit action"
    @date = Date.today 
  end
end
