class PaymentsController < ApplicationController
  include ApplicationHelper
  
  def index
    response = HTTParty.get("#{BASE_URL}payments")
    @data = parse_response(response)
  end
  
  def show
    response = HTTParty.get("#{BASE_URL}payments/#{params[:id]}")
    @data = parse_response(response)
  end
  
  def create
    result = HTTParty.post("#{BASE_URL}payments", 
                              :body => params[:data].to_json,
                              :headers => { 'Content-Type' => 'application/json' } )
    @data = parse_response(result)
    if @data.is_a?(String)
        flash[:danger] = "Error. #{@data}"
        redirect_to :controller => 'payments', :action => 'new'
    else
      flash.now[:success] = "Payment made successfully"
      render :controller => 'payments', :action => 'show', :id => @data[:data][:id]
    end
  end
  
  def new
  end
  
  def destroy
    response = HTTParty.delete("#{BASE_URL}payments/#{params[:id]}")
    if response.code.eql?(200)
      flash[:success] = "Payment transaction deleted successfully"
    else
      flash[:danger] = "Error deleting payment transaction"
    end
    redirect_to action: "index"
  end
end