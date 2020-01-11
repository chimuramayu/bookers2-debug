class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		book = Book.find(params[:book_id])
		# comment = Comment.new(comment_params)
		# comment.user_id = current_user.id
		# comment.book_id = book.id
		# comment.save
		Comment.create(user_id: current_user.id, book_id:  book.id, comment: comment_params[:comment])
		redirect_to request.referer
	end

	def destroy
		comment = Comment.find(params[:id])
		if comment.user != current_user
			redirect_to request.referer
		end
		comment.destroy
		redirect_to request.referer
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
