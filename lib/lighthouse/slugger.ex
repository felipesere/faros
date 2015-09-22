defmodule Lighthouse.Slugger do
  def generate(title) do
    title
    |> String.downcase
    |> String.replace(" ","-")
    |> String.replace(~r/[^\w-]/,"")
  end
end
