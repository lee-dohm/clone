defmodule Clone.Repo do
  @moduledoc """
  Functions for handling repository information.
  """

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
