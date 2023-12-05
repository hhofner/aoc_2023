defmodule AdventOfCode.Day01 do
  @valid_ints [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ]

  def part1(args) do
    result =
      Enum.reduce(args, 0, fn x, acc ->
        parseInt(x) + acc
      end)

    result
  end

  def part2(args) do
    result =
      Enum.reduce(args, 0, fn x, acc ->
        get_total_from_string(x) + acc
      end)

    result
  end

  defp parseInt(some_string) do
    t = List.flatten(Regex.scan(~r/\d+/, some_string))

    (String.at(Enum.at(t, 0), 0) <> String.at(Enum.at(t, -1), -1))
    |> String.to_integer()
  end

  defp get_total_from_string(some_string) do
    IO.puts("handling #{some_string}")

    list_of_ints =
      get_integers_in_string(some_string, 0, [])

    int_result =
      (turn_into_numbers(Enum.at(list_of_ints, -1)) <>
         turn_into_numbers(Enum.at(list_of_ints, 0)))
      |> String.to_integer()

    IO.puts("int_result #{int_result}")

    int_result
  end

  defp turn_into_numbers(string_number) do
    case string_number do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      _ -> string_number
    end
  end

  defp get_integers_in_string("", _, acc) do
    acc
  end

  defp get_integers_in_string(some_string, 18, acc) do
    {_, new} = String.split_at(some_string, 1)
    get_integers_in_string(new, 0, acc)
  end

  defp get_integers_in_string(some_string, valid_int_index, acc) do
    substring = Enum.at(@valid_ints, valid_int_index)

    case String.starts_with?(some_string, substring) do
      true ->
        get_integers_in_string(
          generate_correct_next_string(some_string, substring),
          0,
          [substring | acc]
        )

      false ->
        get_integers_in_string(some_string, valid_int_index + 1, acc)
    end
  end

  defp generate_correct_next_string(some_string, substring) do
    case String.length(substring) do
      1 -> String.replace_prefix(some_string, substring, "")
      _ -> String.at(substring, -1) <> String.replace_prefix(some_string, substring, "")
    end
  end
end
