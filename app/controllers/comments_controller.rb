class CommentsController < ApplicationController
	before_action :ensure_correct_user,{only: [:destroy]}

	def create
		book = Book.find(params[:book_id])
		# comment = Comment.new(comment_params)
		# comment.user_id = current_user.id
		# comment.book_id = book.id
		# comment.save
		Comment.create(user_id: current_user.id, book_id:  book.id, comment: comment_params[:comment])
		redirect_to book_path(book)
	end

	def destroy
		book = Book.find(params[:book_id])
		comment = Comment.find(params[:id])
		comment.destroy
		redirect_to book_path(book)
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end

	def ensure_correct_user
    comment = Comment.find(params[:id])
    if current_user.id != comment.user_id
      redirect_to books_path
    end
  end

end
