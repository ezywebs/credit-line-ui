class DrawsController < ApplicationController
  include ApplicationHelper
  
  def index
    response = HTTParty.get("#{BASE_URL}draws")
    @data = parse_response(response)
  end
  
  def show
    response = HTTParty.get("#{BASE_URL}draws/#{params[:id]}")
    @data = parse_response(response)
  end
  
  def create
    result = HTTParty.post("#{BASE_URL}draws", 
                              :body => params[:data].to_json,
                              :headers => { 'Content-Type' => 'application/json' } )
    @data = parse_response(result)
    if @data.is_a?(String)
      flash[:danger] = "Error. #{@data}"
      redirect_to :controller => 'draws', :action => 'new'
    else
      flash.now[:success] = "Draw made successfully"
      render :controller => 'draws', :action => 'show', :id => @data[:data][:id]
    end
    
  end
  
  def new
  end
  
  def destroy
    response = HTTParty.delete("#{BASE_URL}draws/#{params[:id]}")
    if response.code.eql?(200)
      flash[:success] = "Draw transaction deleted successfully"
    else
      flash[:danger] = "Error deleting draw transaction"
    end
    redirect_to action: "index"
  end
end