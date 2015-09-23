defmodule Lighthouse.Slugger do
  def generate(title) do
    title
    |> String.replace(~r/[\.,;:\/]/,"")
    |> String.downcase
    |> String.replace(" ","-")
  end
end
