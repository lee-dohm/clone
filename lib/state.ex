defmodule Clone.State do
  @moduledoc """
  Represents the state of the application.
  """
  defstruct [:arguments, :invalid_options, :location, :options, :repo_dir]

  @type t :: %__MODULE__{}
  @type parsed_options :: {OptionParser.parsed, OptionParser.argv, OptionParser.errors}

  @doc """
  Creates a `Clone.State` struct from an `OptionParser.parse/2` tuple.
  """
  @spec new(parsed_options) :: t
  def new({options, arguments, invalid}) do
    %__MODULE__{
      arguments: arguments,
      invalid_options: invalid,
      options: coalesce_options(options)
    }
  end

  defp coalesce_options(options) do
    coalesce_options(%{}, options)
  end

  defp coalesce_options(map, []), do: map

  defp coalesce_options(map, [{key, value} | tail]) do
    map
    |> Map.update(key, value, &prepend_value(&1, value))
    |> coalesce_options(tail)
  end

  defp prepend_value(list, value) when is_list(list), do: [value | list]
  defp prepend_value(item, value), do: [value | [item]]
end
