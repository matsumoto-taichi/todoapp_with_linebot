class TasksController < ApplicationController
  # タスク一覧画面
  def index
    @tasks = Task.all
  end

  # 編集画面
  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.task = params[:task]
    if task.save
      redirect_to tasks_index_path, notice: "タスクを１件更新しました"
    else
      redirect_to tasks_index_path, alert: "タスクの更新に失敗しました"
    end
  end

  def delete
    task = Task.find(params[:id])
    if task.destroy
      redirect_to tasks_index_path, notice: "タスクを１件削除しました"
    else
      redirect_to tasks_index_path, alert: "タスクの削除に失敗しました"
    end
  end
end
