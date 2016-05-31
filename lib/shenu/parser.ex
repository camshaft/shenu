defmodule Shenu.Parser do
  defstruct message_type: Shenu.Message.Text,
            schema: nil

  alias __MODULE__.Group

  def new(message_type) when is_atom(message_type) do
    new(message_type, message_type.schema())
  end
  def new(parsers) when is_map(parsers) do
    Group.new(parsers)
  end

  def new(message_type, %{"type" => _} = schema) when is_atom(message_type) do
    %__MODULE__{message_type: message_type,
                schema: Shenu.Schema.init(schema)}
  end
  def new(message_type, opts) when is_atom(message_type) do
    new(message_type, message_type.schema(opts))
  end

  def parse(%Group{} = group, input) do
    Group.parse(group, input)
  end
  def parse(%{message_type: message_type, schema: schema}, input) do
    case Shenu.Schema.validate(schema, input) do
      :ok ->
        message_type.new(input)
      error ->
        error
    end
  end

  def schema(%Group{} = group) do
    Group.schema(group)
  end
  def schema(%{schema: %{schema: schema}}) do
    schema
  end
end
