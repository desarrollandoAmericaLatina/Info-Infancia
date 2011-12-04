class ApiController < ApplicationController
  respond_to :json, :xml

  def locations
    locations = Location.all
    respond_with(locations) do |format|
      format.json { render_for_api :location, :json => locations }
    end
  end
end
