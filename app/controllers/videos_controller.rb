class VideosController < ApplicationController
  before_filter :authenticate_user!
  layout 'ajax', :only => 'showjs'
  # GET /videos
  # GET /videos.json
  def index
    @videos = current_user.videos
    @purchased_videos = current_user.purchased_videos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    if params.has_key? :id
      @video_id = params[:id]
    else
      redirect_to home_index_path, :alert => "Pagina inexistente."
      return
    end

    if !current_user.is_admin?
      @video = Video.video_by_user_permission @video_id, current_user.id
    else
      @video = Video.find @video_id
    end
    
    if !@video
      redirect_to home_index_path, :alert => "Video sem permissao."
      return
    end

    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264"]

    @owner = false
    @owner = true if @video.user.id == current_user.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end


  # GET /videos/new
  # GET /videos/new.json
  def new
    if !current_user.can_add_courses?
      redirect_to home_index_path, :alert => "Atividade bloqueada"
      return
    end

    if !current_user.is_admin?
      @course = Course.find_by_id_and_user_id(params[:course],current_user.id)
    else
      @course = Course.find params[:course]
    end

    if @course.nil?
      redirect_to home_index_path, :alert => "Sem permissao para editar"
      return
    end

    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
end
