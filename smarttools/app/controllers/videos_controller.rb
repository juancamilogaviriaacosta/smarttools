require 'fileutils'

class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
#   @videos = Video.all
    @videos = Video.paginate(:page => params[:page], :per_page=>10)
  end

  def join
    sql = ["SELECT videos.* FROM videos WHERE videos.contest_id = :contest_id", { :contest_id => session[:tmp_contest_id] }]
    @videos = Video.paginate_by_sql(sql, :page => params[:page], :per_page=>10)
    @banner = Contest.find(session[:tmp_contest_id]).banner
    @contest = Contest.find(session[:tmp_contest_id])
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @contest = Contest.find(session[:tmp_contest_id])
    @url_concurso = Contest.find(@video.contest_id).url
  end

  # GET /videos/new
  def new
    @video = Video.new
    @video.contest_id = session[:tmp_contest_id]
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    nombreVideo = SecureRandom.uuid + File.extname(video_params[:videooriginals3].original_filename)
    carpeta = File.join(Rails.public_path, "uploaded_videos", Time.now.strftime("%Y-%m-%d"))
    rutaAbsoluta = File.join(carpeta, nombreVideo)
    FileUtils.mkdir_p(carpeta)
    File.open(rutaAbsoluta, 'wb') do |f|
       f.write(video_params[:videooriginals3].read)
    end

    user = User.find_by(correo: params[:correo_usuario])
    
    if !user
      user = User.create({:nombre => params[:nombre_usuario], :apellido => params[:apellido_usuario], :correo => params[:correo_usuario]})
    end
    
    newParams = {:nombre => video_params[:nombre], :descripcion => video_params[:descripcion], :fechacreacion => Time.now, :urlconvertido => nil,
      :urloriginal => "/uploaded_videos/" + Time.now.strftime("%Y-%m-%d") + "/" + nombreVideo, 
      :contest_id => params[:contest_id], :estado => 'to_proc', :user_id => user.id, :videooriginals3 => video_params[:videooriginals3]}
      
    @video = Video.new(newParams)
    respond_to do |format|
      if @video.save
        @video.convert_to_mp4
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.permit(:nombre,:descripcion, :contest_id, :archivo, :videooriginals3)
    end
  end
