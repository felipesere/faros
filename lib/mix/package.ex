defmodule Mix.Tasks.Package do
  use Mix.Task
  require Git

  def run(_args) do
    Mix.env(:prod)
    ensure_correct_erlang_version

    build_static_files
    build_release
    build_docker_image
  end

  def ensure_correct_erlang_version do
    version = :erlang.system_info(:otp_release)

    File.stream!(".tool-versions")
    |> Enum.map(&(String.strip(&1)))
    |> Enum.find(fn(x) -> String.match?(x,~r/erlang #{version}/) end)
    |> deal_with_version(version)
  end

  def process_css do
    {output, 0} =  System.cmd("#{System.cwd!}/node_modules/brunch/bin/brunch", ["build", "--production"], [stderr_to_stdout: true])
    IO.puts output
  end

  def build_static_files do
    IO.puts "  Compiling static assets"
    process_css
    Mix.Task.run(Phoenix.Digest)
  end

  def build_release do
    IO.puts "  Building release"
    Mix.Task.run(Release)
  end

  def build_docker_image do
    IO.puts "  Building Docker image"
    commit_id = Git.last
    {_, 0} =  System.cmd("docker", ["build", "-t", "felipesere/faros:#{commit_id}", "."], [stderr_to_stdout: false])
    {output, 0} =  System.cmd("docker", ["tag", "-f", "felipesere/faros:#{commit_id}", "felipesere/faros:latest"], [stderr_to_stdout: false])
    
    IO.puts "Form docker '#{output}'"
  end

  defp deal_with_version(nil, version), do: raise "Current erlang (#{version}) does not match .tool-versions"
  defp deal_with_version(_, _),         do: IO.puts "Matching erlang version found"
end
