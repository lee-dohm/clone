defmodule Clone.RepoTest do
  use ExUnit.Case, async: true

  doctest Clone.Repo

  alias Clone.Repo

  describe "parse_location/1" do
    setup do
      {
        :ok,
        github_git_https: "https://github.com/owner/repo.git",
        github_repo_https: "https://github.com/owner/repo",
        github_nwo: "owner/repo",
        github_ssh: "git@github.com:owner/repo.git"
      }
    end

    test "parses a GitHub 'owner/repo' location", context do
      assert Repo.parse_location(context.github_nwo) == {"owner", "repo"}
    end

    test "parses a GitHub ssh location", context do
      assert Repo.parse_location(context.github_ssh) == {"owner", "repo"}
    end

    test "parses a GitHub git https location", context do
      assert Repo.parse_location(context.github_git_https) == {"owner", "repo"}
    end

    test "parses a GitHub repo https location", context do
      assert Repo.parse_location(context.github_repo_https) == {"owner", "repo"}
    end
  end
end
