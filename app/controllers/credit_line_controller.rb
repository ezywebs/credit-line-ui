class CreditLineController < ApplicationController
  include ApplicationHelper
  
  def index
    response = HTTParty.get("#{BASE_URL}credit_lines")
    @data = parse_response(response)
  end
  
  def show
    response = HTTParty.get("#{BASE_URL}credit_lines/#{params[:id]}")
    @data = parse_response(response)
  end
  
  def create
  result = HTTParty.post("#{BASE_URL}credit_lines", 
                            :body => params[:data].to_json,
                            :headers => { 'Content-Type' => 'application/json' } )
  @data = parse_response(result)
  flash.now[:success] = "Credit Line opened successfully"
  render :controller => 'credit_line', :action => 'show', :id => @data[:data][:id]
  end
  
  def new
  end
  
  def destroy
    response = HTTParty.delete("#{ApplicationHelper::BASE_URL}credit_lines/#{params[:id]}")
    if response.code.eql?(200)
      flash[:success] = "Credit Line deleted successfully"
    else
      flash[:danger] = "Error deleting credit line"
    end
    redirect_to action: "index"
  end
end