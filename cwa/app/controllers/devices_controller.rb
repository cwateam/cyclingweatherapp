class DevicesController < ApplicationController
  layout "admin"
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:destroy, :edit, :update]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
#    @device_profile = @device.device_profile
  end

  # GET /devices/new
  def new
    @device = Device.new
    @device_profiles = DeviceProfile.all
  end

  # GET /devices/1/edit
  def edit
    @device_profiles = DeviceProfile.all
  end

  # POST /devices
  # POST /devices.json
  def create
    if current_user.nil?
      redirect_to signin_path
    else
      @device = Device.new(device_params)
      @device.user_id = current_user.id
      @device_profiles = DeviceProfile.all
      respond_to do |format|
        if @device.save
          format.html { redirect_to @device, notice: 'Device was successfully created.' }
          format.json { render :show, status: :created, location: @device }
        else
          format.html { render action: 'new' }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
      respond_to do |format|
        if @device.update(device_params)
          format.html { redirect_to @device, notice: 'Device was successfully updated.' }
          format.json { render :show, status: :ok, location: @device }
        else
          format.html { render :edit }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:id, :user_id, :device_id, :device_profile_id)
    end

    def authenticate
      if current_user != @device.user
        redirect_to devices_path, notice: 'You are not the owner of device ' + @device.id
      end

    end
end
