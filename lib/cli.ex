defmodule Clone.CLI do
  @moduledoc """
  Command-line interface for the clone tool.
  """

  alias Clone.Repo
  require Logger

  def main(args \\ []) do
    {options, words, _} = OptionParser.parse(args, switches: [debug: :boolean, verbose: :boolean],
                                                   aliases: [d: :debug, v: :verbose])

    set_verbosity(options)

    location = List.first(words)
    Logger.debug(fn -> "location = #{location}" end)
    {owner, repo} = Repo.parse_location(location)
    Logger.debug(fn -> "owner = #{owner}" end)
    Logger.debug(fn -> "repo = #{repo}" end)
    home_dir = Path.expand(env(["REPO_HOME", "GITHUB_REPOS_HOME", "ATOM_REPOS_HOME"]))
    Logger.debug(fn -> "home_dir = #{home_dir}" end)
    owner_dir = Path.join(home_dir, owner)
    Logger.debug(fn -> "owner_dir = #{owner_dir}" end)
    repo_dir = Path.join(owner_dir, repo)
    Logger.debug(fn -> "repo_dir = #{repo_dir}" end)

    :ok = ensure_directory(owner_dir)

    Logger.info(fn -> "Execute `hub clone #{location} #{repo_dir}`" end)
    System.cmd("hub", ["clone", location, repo_dir])
  end

  defp ensure_directory(dirname) do
    Logger.debug(fn -> "Execute `mkdir #{dirname}` if necessary" end)

    case File.mkdir(dirname) do
      :ok -> :ok
      {:error, :eexist} -> :ok
      error -> error
    end
  end

  defp env(list) do
    Enum.find_value(list, fn(item) ->
      value = System.get_env(item)

      cond do
        is_nil(value) -> nil
        String.length(value) == 0 -> nil
        true -> value
      end
    end)
  end

  defp set_verbosity(options) do
    if Keyword.get(options, :verbose), do: Logger.configure_backend(:console, level: :info)
    if Keyword.get(options, :debug), do: Logger.configure_backend(:console, level: :debug)
  end
end
