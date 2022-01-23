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
        format.html { redirect_to requests_path, notice: "Request was successfully created." }
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
    puts "anythignn\n\n\n\n\n\n"
    @request.product_list.push(5)
    @request.save
  end

  helper_method :add_product

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
