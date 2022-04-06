module BooksHelper
  
  def book_rate_options
    Book.rate.options.reject { |_, value| value == 0 }
  end
end
