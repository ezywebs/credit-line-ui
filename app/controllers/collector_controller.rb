class CollectorController < ApplicationController
  include ApplicationHelper
  
  def view
    response = HTTParty.get("#{BASE_URL}collector/#{params[:id]}")
    @data = parse_response(response)
  end
  
  def charge
    response = HTTParty.get("#{BASE_URL}collector/charge/#{params[:id]}")
    @data = parse_response(response)
    render 'view'
  end

end