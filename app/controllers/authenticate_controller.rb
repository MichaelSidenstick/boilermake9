class AuthenticateController < ApplicationController
    def main
        code = ""
        if(params[:code])
            code = params[:code].to_s
        end

        if(current_user.productToken.to_s.empty?)
            current_user.update_attribute(:productToken, getToken(code))
            return;
        elsif(current_user.cartToken.to_s.empty?)
            current_user.update_attribute(:cartToken, getToken(code))
            return;
        end
    end

    def reset
        current_user.update_attribute(:productToken, "")
        current_user.update_attribute(:cartToken, "")
        if params[:next] == 'cart'
            redirect_to 'http://localhost:3000/authenticate/cart'
        else
            if params[:next] == 'product'
                redirect_to 'http://localhost:3000/authenticate/cart'
            end
        end 
    end

    def product
        redirect_to "https://api.kroger.com/v1/connect/oauth2/authorize?scope=product.compact&response_type=code&client_id=foodforothers-3a1717e6ccb14a5468f2a4b2317b0cd23285481154538090116&redirect_uri=http://localhost:3000/authenticate"
    end

    def cart
        redirect_to "https://api.kroger.com/v1/connect/oauth2/authorize?scope=cart.basic:write&response_type=code&client_id=foodforothers-3a1717e6ccb14a5468f2a4b2317b0cd23285481154538090116&redirect_uri=http://localhost:3000/authenticate"
    end

    def getToken(code)
        url = URI("https://api.kroger.com/v1/connect/oauth2/token")
    
        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
    
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/x-www-form-urlencoded"
        request["Authorization"] = "Basic Zm9vZGZvcm90aGVycy0zYTE3MTdlNmNjYjE0YTU0NjhmMmE0YjIzMTdiMGNkMjMyODU0ODExNTQ1MzgwOTAxMTY6R09qZ1lGZ2hSU1BKdHFSZjVGTmtrMlhObEZKc2NyZHgyTnJYUktqNQ=="
        request.body = "grant_type=authorization_code&code=" + code + "&redirect_uri=http://localhost:3000/authenticate"
    
        response = https.request(request)
        token = JSON.parse(response.read_body)["access_token"]
    
       # puts response.read_body
        
        return token
    end

end
  