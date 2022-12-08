class AnswersController < ApplicationController
    before_action :set_question!

    def create
        @answer = @question.answers.build answer_params
        if @answer.save
            flash[:success] = "Answer add"
            redirect_to question_path(@question)
        else
            @answers = @question.answers.order created_at: :desc
            render "questions/show"
        end
    end

    def destroy 
        answer = @question.answers.find params[:id]
        answer.destroy
        flash[:success] = "Answer deleted"
        redirect_to question_path(@question)
    end

    def update
        @answer = @question.answers.find params[:id]
        if @answer.update answer_params
            flash[:success] = "Answer update"
            redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
        else
            render plain: "lox"
        end
    end

    def edit
        @answer = @question.answers.find params[:id]
    end


    private
    def set_question!
        @question = Question.find params[:question_id]
    end


    def answer_params
        params.require(:answer).permit(:body)
    end
end
