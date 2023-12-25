defmodule AdventOfCode.Day02 do
  def part1(args) do
    max = %{blue: 14, red: 12, green: 13}

    IO.inspect(args)
    args
    |> Enum.map(fn x ->
      IO.inspect(parse_line(x))
    end)

    args
    |> Enum.reduce(0, fn x, acc ->
      %{blue: blue_amount, red: red_amount, green: green_amount, id: id} = parse_line(x)

      if blue_amount <= max[:blue] and red_amount <= max[:red] and green_amount <= max[:green] do
        String.to_integer(id) + acc
      else
        acc
      end
    end)
  end

  # Bad name - it parses the line and does other stuff too
  # maybe, parse_line_and_return_highest
  defp parse_line(game_string) do
    "Game " <> id = Enum.at(String.split(game_string, ":"), 0)

    game_string
    |> String.split(":")
    |> Enum.at(1)
    |> String.split(";")
    |> Enum.reduce(%{id: id, red: 0, green: 0, blue: 0}, fn x, acc ->
      x
      |> String.split(",")
      |> Enum.reduce(acc, fn y, acc ->
        {color, amount} = parse_color_amount(y)

        if String.to_integer(amount) > acc[color] do
          Map.merge(acc, %{color => String.to_integer(amount)})
        else
          acc
        end
      end)
    end)
  end

  defp parse_color_amount(input) do
    IO.inspect(String.split(input, " "))
    [amount, color] = String.split(String.trim(input), " ")

    case color do
      "green" -> {:green, amount}
      "red" -> {:red, amount}
      "blue" -> {:blue, amount}
      _ -> {:error, "Invalid color"}
    end
  end

  def part2(args) do
    args
    |> Enum.reduce(0, fn (line, acc) -> 
      acc + power_of(line)
    end)
  end

  def power_of(line) do
    %{blue: blue_amount, red: red_amount, green: green_amount, id: _} = parse_line(line)

    blue_amount * red_amount * green_amount
  end
end
