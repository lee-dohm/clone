# Clone Tool for GitHub

> **Note:** I'm no longer using this tool and using [this fish function](https://github.com/lee-dohm/dotfiles/blob/primary/config/fish/functions/clone.fish) in its place. Because this is no longer maintained, I've archived the repository.

An Elixir escript tool to clone GitHub repositories and store them in the structure to which I've become accustomed.

Most people have a directory where they store their software projects. If you're like me and dabble in a lot of different things, that directory can get pretty busy pretty quickly. Fortunately, the way that GitHub is designed, there's an easy way to collect related projects together by organizing them in directories named after the user or organization they belong to. For example, since I work on [Atom](https://atom.io), [Electron](https://electron.atom.io), and my own personal projects, I might have:

```
REPO_HOME
- atom
  + atom
  + tree-view
- electron
  + electron
- lee-dohm
  + tabs-to-spaces
```

But even though the user or org name is built into the clone URL, neither Git nor the [hub tool](https://hub.github.com) make it easy to maintain such a directory structure. This tool makes it simple.

## Prerequisites

* [Elixir][elixir-lang] v1.9 or higher
* [hub][hub]

## Installation

If you already have [Elixir][elixir-lang] installed, the current released version can be installed locally without cloning the repository using:

<!--
The version number in this block should be automatically updated by script/bump.
-->
```shell
mix escript.install github lee-dohm/clone v1.0.0
```

If you want the latest development version, leave off the version tag.

## Use

Execute the script like this:

```shell
clone lee-dohm/clone
```

It will:

1. Create `$REPO_HOME/lee-dohm`, if necessary
1. Execute `hub clone lee-dohm/clone "$REPO_HOME/lee-dohm/clone"`

The tool will also accept Git `https` or `git` URLs rather than just GitHub `owner/repo` combinations.

If the tool cannot detect a reasonable value for `REPO_HOME`, it will log an error and exit.


## Development

This project follows the [GitHub "scripts to rule them all" pattern][scripts-to-rule-them-all]. The contents of the `script` directory are scripts that cover all common tasks:

* `script/bootstrap` &mdash; Installs all prerequisites for a development machine
* `script/test` &mdash; Runs automated tests
* `script/console` &mdash; Opens the development console
* `script/docs` &mdash; Generates developer documentation which can be opened at `doc/index.html`
* `script/build` &mdash; Builds the escript in the development directory
* `script/install` &mdash; Builds the escript and installs it to `$MIX_ESCRIPTS`

See the [CONTRIBUTING guide](CONTRIBUTING.md) for more information.

## License

[MIT](LICENSE.md)

[elixir-lang]: https://elixir-lang.org/
[hub]: https://hub.github.com/
[scripts-to-rule-them-all]: http://githubengineering.com/scripts-to-rule-them-all/
