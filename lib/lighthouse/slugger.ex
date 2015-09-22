defmodule Lighthouse.Slugger do

  def generate(title) do
    title
    |> String.downcase
    |> String.replace(" ","-")
  end
end
