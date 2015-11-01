class AdministratorsController < ApplicationController
  before_action :set_administrator, only: [:show, :edit, :update, :destroy]

  # GET /administrators
  # GET /administrators.json
  def index
#   @administrators = Administrator.all
    @administrators = Administrator.paginate(:page => params[:page], :per_page=>10)
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show
  end

  # GET /administrators/new
  def new
    @administrator = Administrator.new
  end

  # GET /administrators/1/edit
  def edit
  end

  # POST /administrators
  # POST /administrators.json
  def create
    newParams = {:nombre => administrator_params[:nombre], :apellido => administrator_params[:apellido], :correo => administrator_params[:correo], :contrasena => administrator_params[:contrasena]}
    @administrator = Administrator.new(newParams)
    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @administrator, notice: 'El administrador ha sido creado correctamente.' }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
    log_in @administrator
  end

  # PATCH/PUT /administrators/1
  # PATCH/PUT /administrators/1.json
  def update
    respond_to do |format|
      if @administrator.update(administrator_params)
        format.html { redirect_to @administrator, notice: 'El administrador ha sido actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator.destroy
    respond_to do |format|
      format.html { redirect_to administrators_url, notice: 'El administrador ha sido eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
      params.require(:administrator).permit(:nombre, :apellido, :correo, :contrasena, :contrasena_confirmation)
    end

end
