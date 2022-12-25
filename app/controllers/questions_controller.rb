class QuestionsController < ApplicationController
  before_action :require_authentication, except: %i[index show]
  before_action :find_question!, only: %i[edit update destroy show] 
  before_action :fetch_tags, only: %i[new edit]
  before_action :authorize_question!
  after_action :verify_authorized
  


  def index
    @pagy, @questions = pagy Question.all_by_tags(params[:tag_ids])
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build question_params
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

  def authorize_question!
    authorize(@question || Question)
  end

  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def find_question!
    @question = Question.find params[:id]
  end
  def fetch_tags
    @tags = Tag.all
  end

end

