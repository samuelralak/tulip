class SitesController < ApplicationController
  skip_load_and_authorize_resource, only: :urgent
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/urgent
  def urgent
    @sites = Site.where("is_urgent = true")
    @count = Site.where("is_urgent = true").count.to_s
  end


  # GET /sites/active
  def active
    @sites = Site.where("is_active = true")
    @count = Site.where("is_active = true").count.to_s
  end


  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
    @site.build_site_agreed_amount
    @site.build_site_rate
    @site.build_site_square_metre
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def site_transactions
    @site = Site.find(params[:site_id])
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name, :head, :address, :notes, :start_amount,:additional_costs, :city, :mobile, 
        :client, :old_paint_amount, :initial_labour_amount, :initial_material_amount, :is_active, :is_urgent,
        site_agreed_amount_attributes: [:id, :internal, :external, :site_id],
        site_square_metre_attributes: [:id, :internal, :external, :site_id],
        site_rate_attributes: [:id, :internal, :external, :site_id])
    end
end
