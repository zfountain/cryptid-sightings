class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end 
  
  def create
    @encounter = Encounter.find(params[:encounter_id])
    @comment = @encounter.comments.create(comment_params)
    redirect_to encounter_path(@encounter)
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end