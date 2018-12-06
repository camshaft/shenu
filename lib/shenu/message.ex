defprotocol Shenu.Message do
  def difference(a, b, method \\ :default)

  Kernel.defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [defmessage: 1]
      @before_compile unquote(__MODULE__)
    end
  end

  Kernel.defmacro defmessage(schema) do
    quote bind_quoted: binding do
      prefix = Application.get_env(:shenu, :schema_url, "https://cdn.jsdelivr.net/gh/camshaft/shenu/schemas")
      name = Module.split(__MODULE__) |> List.last |> Mix.Utils.underscore()

      schema = schema
      |> Map.put("$schema", "http://json-schema.org/schema#")
      |> Map.put("id", "#{prefix}/#{name}.json#")
      |> Map.put("title", name)
      |> Map.put("description", String.strip(@moduledoc || ""))

      case schema do
        %{type: "object"} ->
          defstruct(for {key, props} <- schema.properties do
            {key, props[:default]}
          end)

          def new(opts \\ %{}) do
            cast(opts)
          end
        _ ->
          default = schema[:default]
          defstruct value: default

          def new(value \\ unquote(default)) do
            %__MODULE__{value: value}
          end
      end

      encoded = Poison.encode!(schema)
      escaped = encoded |> Poison.decode!() |> Macro.escape()

      if Mix.env != :prod do
        File.write!(__DIR__ <> "/../../../schemas/#{name}.json", encoded)
      end

      def schema(_ \\ []) do
        unquote(escaped)
      end
      defoverridable schema: 1
    end
  end

  Kernel.defmacro __before_compile__(_) do
    quote unquote: false do
      defp cast(input) when is_map(input) do
        struct!(__MODULE__, cast_keys(input))
      end
      defp cast(input) when is_list(input) do
        input
        |> Enum.into(%{})
        |> cast()
      end
      defp cast(nil) do
        %__MODULE__{}
      end

      defp cast_keys(input) do
        input
      end

      for {key, _} <- Map.from_struct(@struct) do
        defoverridable cast_keys: 1

        defp cast_keys(input) do
          case Map.pop(input, unquote(to_string(key))) do
            {nil, input} ->
              super(input)
            {value, input} ->
              input
              |> Map.put(unquote(key), value)
              |> super()
          end
        end
      end
    end
  end
end

defimpl Shenu.Message, for: Atom do
  def difference(a, a, _) do
    0
  end
  def difference(_, _, _) do
    1
  end
end
