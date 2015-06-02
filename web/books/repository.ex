defmodule Lighthouse.Books.Repository do
  @books [
    %{
      isbn: "1234567890123",
      title: "How to Ruby",
      slug:  "how-to-ruby",
      description: "This little book is great for learning ruby. It
      teaches you a lot about classes and methods and other fun things
      like that. I found it very helpful as a beginner rubyist.",
      link: "http://www.amazon.com/how-to-ruby"
    },
    %{
      isbn: "1234567890124",
      title: "How to Python",
      slug:  "how-to-python",
      description: "This big book is great for learning python.",
      link: "http://www.amazon.com/how-to-python"
    },
    %{
      isbn: "1234567890125",
      title: "How to Elixir",
      slug:  "how-to-elixir",
      description: "This little book is great for learning elixir. It
      demonstrates pattern matching and functional programming very
      clearly. Good read.",
      link: "http://www.amazon.com/how-to-python"
    },
  ]

  def all(), do: @books

  def find_by_slug(slug) do
    Enum.find(@books, fn (book) -> book[:slug] == slug end)
  end
end
