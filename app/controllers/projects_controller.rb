# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @project = Project.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # rubocop:disable Metrics/AbcSize
  def update_status
    @project = Project.find(params[:id])
    from_status = @project.status

    respond_to do |format|
      if @project.update(status: params[:status])
        comment = Comment.create_status_comment(from_status, current_user, @project)
        CommentBroadcastService.new(comment, current_user).call
        format.json { render json: { status: @project.status, msg: "Status updated" } }
      else
        format.json { render json: { error: @project.errors.full_messages.join } }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status, :user_id)
  end
end
