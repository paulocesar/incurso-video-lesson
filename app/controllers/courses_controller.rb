class CoursesController < ApplicationController
  before_filter :authenticate_user!
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  def own_courses
    @own_courses = Course.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # own_courses.html.erb
      format.json { render json: @own_courses}
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    if params.has_key? :video_id
      @video_id = params[:video_id]
    else
      if @course.videos.first
        @video_id = @course.videos.first.id
      end
    end

    if !@video_id && current_user.is_admin?
      redirect_to new_video_path(:course=>@course.id), :notice => "Adicione um video antes de acessar o curso."
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
    @owner = true if @course.user.id == current_user.id || current_user.is_admin?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    @user = current_user
    @area = Area.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end
end
