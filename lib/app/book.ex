defmodule App.BookFinder do
  @default_filters %{title: nil, author: nil}
  def filter_books(books, filter) do
    %{title: title, author: author} = Map.merge(@default_filters, filter)

    books
    |> filter_by_author(author)
    |> filter_by_book(title)
  end

  defp filter_by_author(books, filter) do
    if filter do
      Enum.filter(books, fn each -> each.author =~ filter end)
    else
      books
    end
  end

  defp filter_by_book(books, filter) do
    if filter do
      Enum.filter(books, fn each -> each.title =~ filter end)
    else
      books
    end
  end
end
