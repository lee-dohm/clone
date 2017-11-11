# Clone

An Elixir escript tool to clone Git repositories and store them in the structure to which I've become accustomed.

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

1. Clone [the repository](https://github.com/lee-dohm/clone) to your local system
1. Run `script/install`

## License

[MIT](LICENSE.md)
