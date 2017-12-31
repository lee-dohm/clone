defmodule Clone.Repo do
  @moduledoc """
  Handles parsing all of the various formats that can be used to represent a GitHub repository.
  """

  @doc """
  Parses the GitHub repository location into an `{owner, repo}` tuple.
  """
  @spec parse_location(String.t) :: {String.t, String.t} | nil
  def parse_location(location) do
    matches = parse_ssh_repo(location) || parse_https_repo(location) || parse_nwo_repo(location)

    case matches do
      nil -> nil
      [_, owner, repo] -> {owner, repo}
      [_, owner, repo, _] -> {owner, repo}
    end
  end

  defp parse_https_repo(name), do: Regex.run(~r{^https://github.com/([^/]+)/([^. \t]+)(\.git)?$}, name)

  defp parse_nwo_repo(name), do: Regex.run(~r{^([^/]+)/(\S+)$}, name)

  defp parse_ssh_repo(name), do: Regex.run(~r{^git@github.com:([^/]+)/([^. \t]+)\.git$}, name)
end
