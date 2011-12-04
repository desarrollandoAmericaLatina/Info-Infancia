class MainController < ApplicationController

  def index
    @json = Event.all.to_gmaps4rails
  end
end