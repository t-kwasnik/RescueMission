class QuestionsController < ApplicationController

  MIN_TITLE_LENGTH = 4
  MIN_DESCRIPTION_LENGTH = 15

  def index
    @questions = Question.all.order("updated_at desc")
  end

  def show
    @question = Question.find(params["id"])
    @new_answer = Answer.new
    @answers = Answer.where(question_id: params["id"]).order("is_favorite desc, updated_at desc")
    @creator = @question.uid

  end

  def edit
    @question = Question.find(params["id"])
  end

  def update

    @question = Question.find(params["id"])

    if @question.uid != current_user.id
      redirect_to '/questions'
    end

    if question_params[:title].length < MIN_TITLE_LENGTH
      flash.now[:notice] = "Please supply a longer title"
      render :new
      return
    elsif question_params[:description].length < MIN_DESCRIPTION_LENGTH
      flash.now[:notice] = "Please supply a longer description"
      render :new
      return
    elsif @question.update(question_params)
      redirect_to '/questions'
    else
      flash.now[:notice] = "Sorry! Save failed...."
      render :new
    end
  end

  def create

    @question = Question.new(question_params)
    @question.uid = session[:user_id]

    if question_params[:title].length < MIN_TITLE_LENGTH
      flash.now[:notice] = "Please supply a longer title"
      render :new
      return
    elsif question_params[:description].length < MIN_DESCRIPTION_LENGTH
      flash.now[:notice] = "Please supply a longer description"
      render :new
      return
    elsif @question.save
      redirect_to '/questions'
    else
      flash.now[:notice] = "Sorry! Save failed...."
      render :new
    end

  end

  def new
    @question = Question.new
  end


  def destroy
    @question = Question.find(params[:id])
    @question.answers.destroy_all
    @question.destroy
    redirect_to questions_path
  end


  private

  def question_params
    # this method will return a hash like this:
    # { title: "whatever title", author: "some person", body: "blah blah blah" }
    params.require(:question).permit(:title, :description)

  end





end
