# * lines_length!/1 that takes a file path and returns a list of numbers, with
#   each number representing the length of the corresponding line from the file.
# * longest_line_length!/1 that returns the length of the longest line in a file.
# * longest_line!/1 that returns the contents of the longest line in a file.
#
# page 101


defmodule Utils do
  def lines_length(filepath) do
    absolute_filepath = get_absolute_path(filepath)

    parse_lines(absolute_filepath)
    |> calculate_lines_with_length
    |> Enum.map(fn {_line, length} -> length end)
  end

  def longest_line_length(filepath) do
    absolute_filepath = get_absolute_path(filepath)
    lines = parse_lines(absolute_filepath)

    sort_lines_by_length(lines)
    |> Enum.at(0)
    |> (fn {_line, length} -> length end).()
  end

  def longest_line(filepath) do
    absolute_filepath = get_absolute_path(filepath)
    lines = parse_lines(absolute_filepath)

    sort_lines_by_length(lines)
    |> Enum.at(0)
    |> (fn {line, _length} -> line end).()
  end

  defp parse_lines(absolute_filepath) do
    File.stream!(absolute_filepath)
    |> Stream.map(fn line -> String.replace(line, "\n", "") end)
  end

  defp calculate_lines_with_length(lines) do
    lines
    |> Stream.map(fn line -> { line, String.length(line) } end)
  end

  defp sort_lines_by_length(lines) do
    calculate_lines_with_length(lines)
    |> Enum.sort_by(&(elem(&1, 1)))
    |> Enum.reverse
  end

  defp get_absolute_path(relative_path) do
    Path.expand(__DIR__ <> "/" <> relative_path)
  end
end

# IO.inspect(Utils.longest_line("./sample-file.txt"))
IO.inspect("#{Utils.lines_length("./sample-file.txt") == [1, 2, 3, 4, 5, 4, 3, 2, 1]} it reads the file and returns the line length for each line")
IO.inspect("#{Utils.longest_line_length("./sample-file.txt") == 5} it reads the file and returns the longest line length")
IO.inspect("#{Utils.longest_line("./sample-file.txt") == "12345"} it reads the file and returns the longest line")
