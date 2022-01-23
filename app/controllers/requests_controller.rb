class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy add_product ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy, :add_product]


  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    #@request = Request.new
    @request = current_user.requests.build
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    #@request = Request.new(request_params)
    @request = current_user.requests.build(request_params)

    

    respond_to do |format|
      if @request.save
        format.html { redirect_to 'http://localhost:3000/requests/new/' + @request.id.to_s + '/add_products', notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to requests_path, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_product
    @request.product_list.push(params[:prod_id])
    
    if @request.save
      redirect_to requests_path + '/' + params[:id].to_s
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @request.errors, status: :unprocessable_entity }
    end
  end 
  
  def product_search
    @term = ''
    @items2 = []  
    if params[:term]
      @term = params[:term]
    else
      @term = 'bread'
    end
    @token = current_user.productToken

    url = URI("https://api.kroger.com/v1/products?filter.term=" + @term.to_s + "&filter.locationId=01400413")


    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Accept"] = "application/json"
    request["Authorization"] = "Bearer " + @token

    response = https.request(request)
    puts "made the request"
    @items = JSON.parse(response.read_body)["data"]
    puts JSON.parse(response.read_body)["status"]
    @items.each { |item|
        string = item["upc"] + ", " + item["description"].to_s + ", " + item["items"][0]["price"]["regular"].to_s + " https://www.kroger.com/product/images/medium/front/" + item["upc"] 
        @items2.push(string)
        puts string
    }
    @items2
    if @term != 'bread'
    end
  end

  def product_search_redirect
    puts params[:term].to_s
    redirect_to 'http://localhost:3000/requests/new/' + params[:id].to_s + '/add_products?term=' + params[:term].to_s
  end
  
  def add_to_cart
    # Create HTTP Reqeuest
    url = URI("https://api.kroger.com/v1/cart/add")
  
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
  
    # Set headers for HTTP Request
    req = Net::HTTP::Put.new(url)
    req["Accept"] = "application/json"
    req["Authorization"] = "Bearer " + current_user.cartToken
  
    # Create body for HTTP Reqeuest
    jsonString = "{\"items\": ["
    Request.find(params[:id]).product_list.each {|item| 
        jsonString += "{\"upc\": \"" + item .to_s+ "\",\"quantity\":1},"
    } 
    jsonString = jsonString[0...-1]
    jsonString += "]}"
  
    req.body = jsonString
  
    # Submit Reqeuest
    response = https.request(req)

    puts current_user.cartToken
    puts response.body
  end

  def correct_user
    @request = current_user.requests.find_by(id: params[:id])
    redirect_to request_path, notice: "Not Authorized to edit this request" if @request.nil?
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:name, :product_list, :cost, :status, :requester_id, :donor_id, :exp_date)
    end

end
