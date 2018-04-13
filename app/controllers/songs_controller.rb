require "pry"
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genre = Genre.new
    @artist = Artist.new
  end

  def create
    @song = Song.new(song_params)
    genre = Genre.find(song_genre_id_param)
    @song.genre = genre

    song_notes_params.each_value do |note|
      if note != ""
        n = Note.create(content: note)
        @song.notes << n
      end
    end

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    print params
    @song = Song.find(params[:id])
    @genre = Genre.new
    @artist = Artist.new
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)
    @song.genre = Genre.find(song_genre_id_param)

    if song_notes_params[:song_notes_1] != "" && song_notes_params[:song_notes_2] != ""
      @song.notes_1 = song_notes_params[:song_notes_1]
      @song.notes_2 = song_notes_params[:song_notes_2]
    end

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end

  def song_genre_id_param
    params.require(:song).permit(:song_genre_id)[:song_genre_id]
  end

  def song_notes_params
    params.require(:song).permit(:notes_1, :notes_2)
  end
end
