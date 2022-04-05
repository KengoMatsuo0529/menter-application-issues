class PostCommentsController < ApplicationController
  
  def create
    user = current_user
    book_detail = Book.find(params[:book_id])
    comment = user.post_comments.new(post_comment_params)
    comment.book_id = book_detail.id
    comment.save
    redirect_to request.referer
  end
  
  def destroy
    comment = PostComment.find_by(params[:id])
    comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
