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
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
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
    newFileName = video_params[:nombre] + File.extname(video_params[:archivo].original_filename)
    path = File.join("uploaded_videos","to_process", video_params[:contest_id] ,)
    fullFilePath = File.join(path,newFileName)

    FileUtils.mkdir_p(path);
    File.open(fullFilePath, 'wb') {|f| f.write(video_params[:archivo].read)}

    newParams = {:nombre => video_params[:nombre], :descripcion => video_params[:descripcion], :fechacreacion => Time.now, :urlconvertido => nil,
      :urloriginal => fullFilePath, :contest_id => video_params[:contest_id], :estado => 'to_proc'}

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
      params.require(:video).permit(:nombre,:descripcion, :contest_id, :archivo)
    end
  end
