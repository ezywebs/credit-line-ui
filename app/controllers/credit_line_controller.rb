class CreditLineController < ApplicationController
  def index
    response = HTTParty.get('https://creditline-eng80lvl.c9users.io/api/v1/credit_lines')
    parse_response(response)
  end
  
  def show
    response = HTTParty.get("https://creditline-eng80lvl.c9users.io/api/v1/credit_lines/#{params[:id]}")
    parse_response(response)
  end
  
  def create
   
  end
  
  def new
     @result = HTTParty.post("https://creditline-eng80lvl.c9users.io/api/v1/credit_lines", 
                            :body => { :limit => "", :apr => "" }.to_json,
                            :headers => { 'Content-Type' => 'application/json' } )
  end
  
  private
  def parse_response(response)
    @data = nil
    case response.code
      when 200
        @data = JSON.parse(response.body).with_indifferent_access
      when 404
        @data = "Not found"
      when 500...600
        @data = "ERROR #{response.code}"
      else
        @data = "Unknown ERROR"
    end
  end
end