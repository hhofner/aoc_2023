defmodule AdventOfCode.Day01 do
  def part1(args) do
    result =
      Enum.reduce(args, 0, fn x, acc ->
        parseInt(x) + acc
      end)

    result
  end

  def part2(_args) do
  end

  defp parseInt(some_string) do
    t = List.flatten(Regex.scan(~r/\d+/, some_string))

    (String.at(Enum.at(t, 0), 0) <> String.at(Enum.at(t, -1), -1))
    |> String.to_integer()
  end
end
