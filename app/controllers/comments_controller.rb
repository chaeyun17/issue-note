class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @note = Note.find(params[:note_id])
    if user_signed_in?
      @user_who_commented = @current_user
      @comment = Comment.build_from(@note, @user_who_commented.id, comment_params[:body])
      @comment.save
    end
    redirect_to note_path(@note)
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @note = Note.find(params[:note_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.json { render :show, status: :ok, location: @note }
        format.html { redirect_to note_path(@note), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    @note = Note.find(params[:note_id])
    redirect_to note_path(@note)
    # respond_to do |format|
    #   format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
