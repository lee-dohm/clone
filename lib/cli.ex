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

    location = get_location(words)

    repo_dir =
      location
      |> Repo.parse_location()
      |> get_repo_dir()

    :ok =
      repo_dir
      |> Path.dirname()
      |> ensure_directory()

    execute_hub(["clone", location, repo_dir])
  end

  defp ensure_directory(directory) do
    Logger.debug(fn -> "Ensure `#{directory}` exists" end)

    case File.mkdir(directory) do
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

  defp execute_hub(args) do
    Logger.info(fn -> "Execute `hub #{Enum.join(args, " ")}`" end)
    System.cmd("hub", args)
  end

  defp get_location(args) do
    location = List.first(args)
    Logger.debug(fn -> "location = #{location}" end)

    location
  end

  defp get_repo_dir({owner, repo}) do
    Logger.debug(fn -> "owner = #{owner}" end)
    Logger.debug(fn -> "repo = #{repo}" end)

    repo_dir = Path.join([repo_home(), owner, repo])

    Logger.debug(fn -> "repo_dir = #{repo_dir}" end)

    repo_dir
  end

  defp repo_home do
    repo_home = Path.expand(env(["REPO_HOME", "GITHUB_REPOS_HOME", "ATOM_REPOS_HOME"]))

    Logger.debug(fn -> "Repo home = #{repo_home}" end)

    repo_home
  end

  defp set_verbosity(options) do
    if Keyword.get(options, :verbose), do: Logger.configure_backend(:console, level: :info)

    if Keyword.get(options, :debug) do
      Logger.configure_backend(:console, level: :debug)
      System.put_env("HUB_VERBOSE", "1")
    end
  end
end
