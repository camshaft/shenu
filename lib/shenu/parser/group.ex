defmodule Shenu.Parser.Group do
  defstruct types: %{},
            schema: %{}

  def new(parsers) do
    {types, schemas} = parsers |> Enum.reduce({%{}, %{}}, &init/2)
    %__MODULE__{types: types,
                schema: %{"type" => "object",
                          "properties" => schemas,
                          "additionalProperties" => false}}
  end

  defp init({key, message_type}, acc) when is_atom(message_type) do
    acc(acc, key, message_type, message_type.schema())
  end
  defp init({key, {message_type, %{"type" => _} = schema}}, acc) when is_atom(message_type) do
    acc(acc, key, message_type, schema)
  end
  defp init({key, {message_type, opts}}, acc) when is_atom(message_type) do
    acc(acc, key, message_type, message_type.schema(opts))
  end

  defp acc({types, schemas}, key, message_type, schema) do
    {Map.put(types, key, message_type), Map.put(schemas, key, schema)}
  end

  def parse(%{schema: schema, types: types}, input) when is_map(input) do
    case Shenu.Schema.validate(schema, input) do
      :ok ->
        Enum.reduce(types, %{}, fn({key, type}, acc) ->
          case Map.get(input, key) do
            nil ->
              Map.put(acc, key, nil)
            value ->
              Map.put(acc, key, type.new(value))
          end
        end)
      error ->
        error
    end
  end

  def schema(%{schema: schema}) do
    schema
  end
end
