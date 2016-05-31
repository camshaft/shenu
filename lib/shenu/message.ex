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
      case schema do
        %{type: "object"} ->
          defstruct(for {key, _} <- schema.properties do
            {key, nil}
          end)

          def new(opts \\ %{}) do
            cast(opts)
          end
        _ ->
          defstruct value: nil

          def new(value \\ nil) do
            %__MODULE__{value: value}
          end
      end

      bin = schema |> Poison.encode!() |> Poison.decode!() |> Macro.escape()

      def schema(_ \\ []) do
        unquote(bin)
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
