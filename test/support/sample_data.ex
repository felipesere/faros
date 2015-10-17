defmodule Faros.SampleData do
  alias Faros.Slugger

  def sample_book(title \\ "That Book") do
    %{
      isbn:  "1234567890123",
      title: title,
      slug:  Slugger.generate(title),
      description: "Its pretty cool.",
      link:  "http://example.com/books/that-book"
    }
  end

  def sample_paper(title \\ "My Fancy Paper" ) do
    %{
      title: title,
      author: "Mister Doctor Esquire",
      slug:  Slugger.generate(title),
      description: "My research from 1845",
      link: "www.fancy-paper-r-us.com/fancy-paper"
    }
  end
end
