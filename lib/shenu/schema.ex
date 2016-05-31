defmodule Shenu.Schema do
  defmodule InputError do
    defexception [:message, :path]
  end

  def init(schema) do
    ExJsonSchema.Schema.resolve(schema)
  end

  def validate(schema, value) do
    case ExJsonSchema.Validator.validate(schema, value) do
      :ok ->
        :ok
      {:error, errors} ->
        {:error, Enum.map(errors, &format_error(&1))}
    end
  end

  defp format_error({message, path}) do
    ## TODO turn the string errors into a error-specific structs
    %InputError{message: message, path: path}
  end
end
