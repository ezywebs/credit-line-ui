module ApplicationHelper
  BASE_URL = "https://creditline-eng80lvl.c9users.io/api/v1/"
    
  def parse_response(response)
    data = nil
    case response.code
      when 200
        data = JSON.parse(response.body).with_indifferent_access
      when 404
        data = "Not found"
      when 500...600
        data = "ERROR #{response.code}"
      else
        data = JSON.parse(response.body)["message"]
    end
    data
  end
end
