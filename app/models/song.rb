class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    if self.genre
      self.genre.name
    else
      nil
    end
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    if self.artist
      self.artist.name
    else
      nil
    end
  end

  def notes_1=(note)
    @notes ||= []
    @notes << note
  end

  def notes_1

  end

  def notes_2=(note)
    @notes ||= []
    @notes << note
  end

  def notes_2

  end

  def note_contents=(notes)
    notes.each do |note|
      self.notes << Note.create(content: note)
    end
  end

  def note_contents
    self.notes.collect { |note_instance| note_instance.content}.select {|note| note != ""}

  end

end
