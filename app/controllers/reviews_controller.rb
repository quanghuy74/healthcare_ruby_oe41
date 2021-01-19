class ReviewsController < ApplicationController
  before_action :correct_account, only: :destroy

  def create
    @review = current_account.rated_reviews.build review_staff_params
    if @review.save
      flash[:success] = t "views.accounts.review.success"
    else
      flash[:danger] = t "views.accounts.review.fail"
    end
    redirect_to @review.reviewable
  end

  def destroy
    if @review.destroy
      flash[:success] = t "views.accounts.review.success"
    else
      flash[:danger] = t "views.accounts.review.fail"
    end
    redirect_to @review.reviewable
  end

  private

  def review_staff_params
    params.require(:review)
          .permit(:content, :rate, :reviewable_id, :reviewable_type)
  end

  def correct_account
    return if @review = current_account.rated_reviews.find_by(id: params[:id])

    flash[:danger] = t "user.incorrect_user"
    redirect_to root_url
  end
end
