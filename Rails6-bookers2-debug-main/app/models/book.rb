class Book < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :users, through: :favorites
    has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  enumerize :rate, in: %i[0 1 2 3 4 5], default: 0

  validates :title, presence:true
  validates :body,  presence:true, length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search,word)
    if search == "forward_search"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_search"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "perfect_match"
      @book = Book.where("#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.category_search(category)
    Book.where(['category LIKE ?', "#{category}"])
  end
end
