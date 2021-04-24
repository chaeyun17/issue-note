# require 'rubygems'
# require 'mechanize'

class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /notes or /notes.json
  def index
    # @notes = Note.all
    if params[:title].nil?
      @notes = Note.all
    else
      puts params[:title]
      @notes = Note.where(title: params[:title])
    end
  end

  # GET /notes/1 or /notes/1.json
  def show
    @note.increment!(:view_count)
  end

  # GET /notes/newo
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    if @note.article_link.present?
      @article = crawl(@note.article_link, @note)
      @note.save
      @article.note = @note
      @article.save
    end


    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @notes = Note.all
  end

  def like
    set_note
    if user_signed_in?
      if @current_user.voted_for? @note
        @note.unliked_by @current_user
      else
        @note.liked_by @current_user
      end
    end
    redirect_to note_path(@note)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body, :photo, :content, :tag_list, :article_link)
    end

    def crawl(article_link, note)
      agent = Mechanize.new
      page = agent.get(article_link)
      
      url = article_link
      title = page.search("//meta[@property='og:title']/@content").text
      summary = page.search("//meta[@property='og:description']/@content").text
      publishedAt = page.search("//meta[@property='og:regDate']/@content").text
      press = ''
      reporter = ''
      # press = page.search("//em[@class='info_cp']/a/@href").text
      # reporter = page.search("//span[@class='info_view']/span[@class='txt_info']").first.text

      article = Article.new(:url=>url, :title=>title, :summary=>summary, :press=>press, :publishedAt=>publishedAt, :reporter=>reporter)

      return article
    end
end
