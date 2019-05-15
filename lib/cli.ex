defmodule Clone.CLI do
  @moduledoc """
  Handles the command-line interface for the program.

  This module contains the entry point, parses the command-line arguments and options, and houses
  the main control flow of the program.
  """

  alias Clone.Repo
  alias Clone.State

  require Logger

  @doc """
  The entry-point for the program.
  """
  @spec main([String.t()]) :: no_return
  def main(args) do
    args
    |> parse_arguments
    |> run
  end

  @doc """
  Parses the command-line arguments and generates the `Clone.State` struct.
  """
  @spec parse_arguments([String.t()]) :: State.t()
  def parse_arguments(args) do
    args
    |> OptionParser.parse(
      switches: [
        debug: :boolean,
        verbose: :boolean
      ],
      aliases: [
        d: :debug,
        v: :verbose
      ]
    )
    |> State.new()
  end

  @doc """
  Executes the main control flow of the program.
  """
  @spec run(State.t()) :: no_return
  def run(%State{} = state) do
    state
    |> set_verbosity
    |> parse_location
    |> parse_repo_dir
    |> ensure_parent_directory
    |> execute_hub
    |> set_exit_status
  end

  defmacrop log_state(state) do
    quote do
      Logger.debug(fn -> "Starting #{format_function(__ENV__.function)}" end)
      Logger.debug(fn -> "State: #{inspect(unquote(state))}" end)
    end
  end

  defp ensure_directory(directory) do
    Logger.debug(fn -> "Ensure `#{directory}` exists" end)

    case File.mkdir(directory) do
      :ok -> :ok
      {:error, :eexist} -> :ok
      error -> error
    end
  end

  defp ensure_parent_directory(%{repo_dir: repo_dir} = state) do
    log_state(state)

    :ok =
      repo_dir
      |> Path.dirname()
      |> ensure_directory

    state
  end

  defp execute_hub(%{location: location, repo_dir: repo_dir} = state) do
    log_state(state)

    execute_hub(["clone", location, repo_dir])
  end

  defp execute_hub(list) when is_list(list) do
    Logger.info(fn -> "Execute `hub #{Enum.join(list, " ")}`" end)

    System.cmd("hub", list)
  end

  defp format_function({name, arity}), do: "#{name}/#{arity}"

  defp parse_location(%{arguments: [head | _]} = state) do
    log_state(state)

    %State{state | location: head}
  end

  defp parse_repo_dir(%{location: location} = state) do
    log_state(state)

    {owner, repo} = Repo.parse_location(location)

    %State{state | repo_dir: Path.join([repo_home(), owner, repo])}
  end

  defp repo_home do
    "REPO_HOME"
    |> System.get_env()
    |> Path.expand()
  end

  defp set_exit_status({_, status}), do: exit({:shutdown, status})

  defp set_verbosity(%{options: %{debug: true}} = state) do
    log_state(state)

    Logger.configure_backend(:console, level: :debug)
    System.put_env("HUB_VERBOSE", "1")

    state
  end

  defp set_verbosity(%{options: %{verbose: true}} = state) do
    log_state(state)

    Logger.configure_backend(:console, level: :info)

    state
  end

  defp set_verbosity(state), do: state
end
