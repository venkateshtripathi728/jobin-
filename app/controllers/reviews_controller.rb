class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy,:edit,:update]

  def create
    @review = Review.new(reviews_params)
    authorize @review
    @interview = Interview.find(params[:interview_id])
    @review.interview = @interview
    if @review.save
    #  redirect_to apply_path(@review.interview.apply.id)
    else
  #    @display_modal = true
    #  redirect_to apply_path(@review.interview.apply.id)
    end
  end


  def edit
    authorize @review
  end

  def update
    if @review.update(review_params)
      redirect_to apply_path(@review.interview.apply)
    else
      render :new
    end
    authorize @review
  end

  def destroy
    @review.destroy
    redirect_to apply_path(@review.interview.apply)
    authorize @review
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def reviews_params

    params.require(:review).permit(:comment,:rating)

  end

end
