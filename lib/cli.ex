defmodule Clone.CLI do
  @moduledoc """
  Command-line interface for the clone tool.
  """

  alias Clone.Repo
  require Logger

  def main(args \\ []) do
    {_, words, _} = OptionParser.parse(args)

    location = List.first(words)
    {owner, repo} = Repo.parse_location(location)
    home_dir = Path.expand(env(["REPO_HOME", "GITHUB_REPOS_HOME", "ATOM_REPOS_HOME"]))
    owner_dir = Path.join(home_dir, owner)
    repo_dir = Path.join(owner_dir, repo)
    Logger.debug("repo_dir = #{repo_dir}")

    :ok = ensure_directory(owner_dir)
    System.cmd("hub", ["clone", location, repo_dir])
  end

  defp ensure_directory(dirname) do
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
end
