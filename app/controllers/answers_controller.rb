class AnswersController < ApplicationController

  MIN_ANSWER_LENGTH = 10

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if answer_params["description"].length < MIN_ANSWER_LENGTH
      flash[:notice] = "Please supply a longer answer"
      redirect_to question_path(@question)
    elsif @answer.save
      redirect_to question_path(@question)
    else
      flash.now[:notice] = "Sorry! Save failed...."
      render :new
    end
  end

  private

  def answer_params
    # this method will return a hash like this:
    # { title: "whatever title", author: "some person", body: "blah blah blah" }
    params.require(:answer).permit(:description, :question_id)
  end
end
