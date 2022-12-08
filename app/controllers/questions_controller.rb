class QuestionsController < ApplicationController
  before_action :find_question!, only: %i[edit update destroy show] 

  def index
    @pagy, @questions = pagy Question.order created_at: :desc
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    
  end
  
  def update
    if @question.update question_params
      flash[:success] = "Question updated!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy
    redirect_to questions_path status: :see_other
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers
    @answers = @answers.decorate
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question!
    @question = Question.find params[:id]
  end

end

