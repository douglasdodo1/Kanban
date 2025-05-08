# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.all
    @task = Task.new
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    result = TaskService.new(task_params).create

    if result.success?
      @task = result.task
      respond_to do |format|
        format.json { render :show, status: :created, location: @task }
      end
    else
      @task   = Task.new(task_params)
      @errors = result.errors
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:tittle, :description, :status, :priority, :assignee)
  end
end
