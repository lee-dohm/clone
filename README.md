# Clone

An Elixir escript tool to clone Git repositories and store them in the structure to which I've become accustomed.

Most people have a directory where they store their software projects. If you're like me and dabble in a lot of different things, that directory can get pretty busy pretty quickly. Fortunately, the way that GitHub is designed, there's an easy way to collect related projects together by organizing them in directories named after the user or organization they belong to. For example, since I work on [Atom](https://atom.io), [Electron](https://electron.atom.io), and my own personal projects, I might have:

```
REPO_HOME
+ atom
  - atom
  - tree-view
+ electron
  - electron
+ lee-dohm
  - tabs-to-spaces
```

But even though the user or org name is built into the clone URL, neither Git nor the [hub tool](https://hub.github.com) make it easy to maintain such a directory structure. This tool makes it simple.

## Use

Execute the script like this:

```shell
$ clone lee-dohm/clone
```

And it will:

1. Create `$REPO_HOME/lee-dohm`, if necessary
1. Execute `hub clone lee-dohm/clone "$REPO_HOME/lee-dohm/clone"`

The tool will also accept Git `https` or `git` URLs rather than just GitHub `owner/repo` combinations.

If the tool cannot detect a reasonable value for `REPO_HOME`, it will log an error and exit.

## Installation

The current released version can be installed locally without cloning the repository using:

<!--
The version number in this block should be automatically updated by script/bump.
-->
```shell
mix escript.install github lee-dohm/clone v0.2.0
```

If you want the latest development version, leave off the version tag.

## Development

This project follows the [GitHub "scripts to rule them all" pattern](http://githubengineering.com/scripts-to-rule-them-all/). The contents of the `script` directory are scripts that cover all common tasks:

* `script/bootstrap` &mdash; Installs all prerequisites for a development machine
* `script/test` &mdash; Runs automated tests
* `script/console` &mdash; Opens the development console
* `script/docs` &mdash; Generates developer documentation which can be opened at `doc/index.html`
* `script/build` &mdash; Builds the escript in the development directory
* `script/install` &mdash; Builds the escript and installs it to `$MIX_ESCRIPTS`

## License

[MIT](LICENSE.md)
