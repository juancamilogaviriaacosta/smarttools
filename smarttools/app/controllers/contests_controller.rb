class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  def join
      @contest = Contest.find_by_url("http://" + request.host + ":" + (request.port.to_s) + "/contests/join/" +params[:uuid])
      if (@contest)
        session[:tmp_uuid] = @contest.id
        redirect_to("/videos/new")
      else
        redirect_to("/404.html")
      end
  end

  # GET /contests
  # GET /contests.json
  def index
#   @contests = Contest.all
    adminConstest = Contest.find_by(administrator_id: current_user)
    if adminConstest
      @contests = Contest.where(administrator_id: current_user).paginate(:page => params[:page], :per_page=>10)
    else 
      @contests = nil
    end
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
    @contest.url = SecureRandom.uuid
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests
  # POST /contests.json
  def create

    nombreImagen = SecureRandom.uuid + File.extname(contest_params[:banner].original_filename)
    carpeta = File.join(Rails.public_path, "uploaded_images", Time.now.strftime("%Y-%m-%d"))
    rutaAbsoluta = File.join(carpeta, nombreImagen)
    FileUtils.mkdir_p(carpeta)
    File.open(rutaAbsoluta, 'wb') do |f|
       f.write(contest_params[:banner].read)
    end
    
    params[:contest][:banner] = "/uploaded_images/" + Time.now.strftime("%Y-%m-%d") + "/" + nombreImagen
    params[:contest][:url] = "http://" + request.host + ":" + (request.port.to_s) +"/contests/join/" + params[:contest][:url]
    params[:contest][:administrator_id] = current_user.id;
    @contest = Contest.new(contest_params)

    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    nombreImagen = SecureRandom.uuid + File.extname(contest_params[:banner].original_filename)
    carpeta = File.join(Rails.public_path, "uploaded_images", Time.now.strftime("%Y-%m-%d"))
    rutaAbsoluta = File.join(carpeta, nombreImagen)
    FileUtils.mkdir_p(carpeta)
    File.open(rutaAbsoluta, 'wb') do |f|
       f.write(contest_params[:banner].read)
    end
    
    params[:contest][:banner] = "/uploaded_images/" + Time.now.strftime("%Y-%m-%d") + "/" + nombreImagen
    params[:contest][:url] = "http://" + request.host + ":" + (request.port.to_s) +"/contests/join/" + params[:contest][:url]

    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:nombre, :banner, :url, :descripcion, :premio, :fechainicio, :fechafin, :administrator_id)
    end
end
