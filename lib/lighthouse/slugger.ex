defmodule Lighthouse.Slugger do
  def generate(title) do
    title
    |> String.downcase
    |> replace_whitespace
    |> remove_non_word_charactes
  end

  def replace_whitespace(title) do
    String.replace(title, " ","-")
  end

  def remove_non_word_charactes (title) do
    String.replace(title, ~r/[^\w-]/,"")
  end
end
