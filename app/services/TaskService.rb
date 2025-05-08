require "ostruct"

class TaskService
  def initialize(params)
    @params = params
    @task   = Task.new(@params)
  end

  def create
    return failure("Priority must be between 0 and 3") unless (0..3).include?(@params[:priority].to_i)
    return failure("Tittle can't be blank")        if @params[:tittle].blank?
    return failure("Description can't be blank")   if @params[:description].blank?
    return failure("task alredy exists")       if Task.exists?(tittle: @params[:tittle], description: @params[:description])

    if @task.save
      success(@task)
    else
      failure(@task.errors.full_messages)
    end
  end

  private

  def success(task)
    ::OpenStruct.new(success?: true, task: task)
  end

  def failure(errors)
    ::OpenStruct.new(success?: false, errors: Array(errors))
  end
end
