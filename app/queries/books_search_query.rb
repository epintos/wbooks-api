class BooksSearchQuery
  attr_reader :scope

  def initialize(scope = Book.all)
    @scope = scope
  end

  def query(genre: nil, author: nil, title: nil)
    @scope = scope.where('genre ILIKE ?', "%#{genre}%") if genre.present?
    @scope = scope.where('author ILIKE ?', "%#{author}%") if author.present?
    @scope = scope.where('title ILIKE ?', "%#{title}%") if title.present?
    @scope
  end
end
