class AnswersController < ApplicationController

  MIN_ANSWER_LENGTH = 10

  def update
    @question = Question.find(params[:question_id])

    if @question.uid != current_user.id
      redirect_to '/questions'
    end

    @current_favorite = Answer.where(question_id: params[:question_id]).where(is_favorite: true)
    if !@current_favorite.empty?
      @current_favorite[0].is_favorite = false
      @current_favorite[0].save
    end
    @answer = Answer.find(params[:id])
    @answer.is_favorite = true
    @answer.save

    redirect_to question_path(@question)
  end



  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.uid = session[:user_id]
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
