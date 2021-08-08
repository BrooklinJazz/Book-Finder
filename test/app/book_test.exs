defmodule App.BookFinderTest do
  use ExUnit.Case
  alias App.BookFinder

  setup do
    expected_book = %{title: "The Name of the Wind", author: "Patrick Rothfuss"}
    not_expected_book = %{title: "We Are Legion (We are Bob)", author: "Dennis E. Taylor"}
    books = [expected_book, not_expected_book]

    %{
      expected_book: expected_book,
      not_expected_book: not_expected_book,
      books: books
    }
  end

  describe "BookFinder.filter_books/2 by book title" do
    test "filter by full book title", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{title: expected_book.title}) == [expected_book]
    end

    test "filter by partial book title", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{title: String.slice(expected_book.title, 1..6)}) ==
               [expected_book]
    end

    test "filter by no book title", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{}) == books
    end

    test "filter by non matching book title", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{title: "Non Matching Example"}) == []
    end
  end

  describe "BookFinder.filter_books/2 by author" do
    test "filter by full author name", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{author: expected_book.author}) == [expected_book]
    end

    test "filter by partial author name", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{author: String.slice(expected_book.author, 1..6)}) ==
               [expected_book]
    end

    test "filter by no author name", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{}) == books
    end

    test "filter by non matching author name", %{books: books, expected_book: expected_book} do
      assert BookFinder.filter_books(books, %{author: "Non Matching Example"}) == []
    end
  end

  describe "BookFinder.filter_books/2 by book title and author name" do
    test "filter by full book title and partial author name", %{
      books: books,
      expected_book: expected_book
    } do
      assert BookFinder.filter_books(books, %{
               title: expected_book.title,
               author: String.slice(expected_book.author, 1..6)
             }) == [expected_book]
    end

    test "filter by partial book title and non matching author name", %{
      books: books,
      expected_book: expected_book
    } do
      assert BookFinder.filter_books(books, %{
               title: String.slice(expected_book.title, 1..6),
               author: "Non Matching Example"
             }) ==
               []
    end

    test "filter by no book title and no author name finds all books", %{
      books: books,
      expected_book: expected_book
    } do
      assert BookFinder.filter_books(books, %{}) == books
    end

    test "filter by non matching book title and full author name", %{
      books: books,
      expected_book: expected_book
    } do
      assert BookFinder.filter_books(books, %{
               title: "Non Matching Example",
               author: expected_book.author
             }) == []
    end
  end
end
