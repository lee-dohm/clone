defmodule Clone.Repo.Spec do
  use ESpec, async: true

  alias Clone.Repo

  describe "parse_location" do
    let :github_git_https, do: "https://github.com/owner/repo.git"
    let :github_repo_https, do: "https://github.com/owner/repo"
    let :github_nwo, do: "owner/repo"
    let :github_ssh, do: "git@github.com:owner/repo.git"

    it "parses a GitHub 'owner/repo' location" do
      expect(Repo.parse_location(github_nwo())).to(eq {"owner", "repo"})
    end

    it "parses a GitHub ssh location" do
      expect(Repo.parse_location(github_ssh())).to(eq {"owner", "repo"})
    end

    it "parses a GitHub git https location" do
      expect(Repo.parse_location(github_git_https())).to(eq {"owner", "repo"})
    end

    it "parses a GitHub repo https location" do
      expect(Repo.parse_location(github_repo_https())).to(eq {"owner", "repo"})
    end
  end
end
