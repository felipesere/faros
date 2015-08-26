defmodule Git do
  defmacro last do
    sha(env, git) |> String.strip
  end

  def sha(nil, git), do: git
  def sha(env,  _ ), do: env

  def env, do: System.get_env("CIRCLE_SHA1") 

  def git do
    case System.cmd("git",["rev-parse", "--short", "HEAD"],[]) do
      {sha, 0} -> sha
      _ -> nil
    end
  end
end

