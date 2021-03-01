defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  # defp handle_file({:ok, result}) do
  #   result =
  #   result = String.split(result, ",")
  #   result = Enum.map(result, fn number -> String.to_integer(number) end)
  #   result = Enum.sum(result)
  #   result
  # end

  # Linguagem imutável por isso é necessário reatribuir o valor da variável,
  # Pipe Operator compondo as funções e agregando resultado.

  defp handle_file({:ok, result}) do
    result =
    result
    |> String.split(",")
    |> Stream.map(fn number -> String.to_integer(number) end)
    |> Enum.sum()

    {:ok, %{result: result}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
