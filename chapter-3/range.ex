# Create a range/2 function that takes two integers, from and to, and returns a list of all numbers in
# a given range.
# page 91

defmodule Utils do
  def range(from, to) do
    build_range(from, to, [])
  end

  defp build_range(from, to, range) when from > to do
    range
  end

  defp build_range(from, to, range) do
    build_range(from, to - 1, [to | range])
  end
end

IO.inspect("#{Utils.range(2, 4) == [2, 3, 4]} it produces a range")
IO.inspect("#{Utils.range(2, 2) == [2]} it produces a single list range when from and two are the same")
IO.inspect("#{Utils.range(5, 1) == []} it produces an empty list when from is greater than to")
IO.inspect("#{Utils.range(-4, -1) == [-4, -3, -2, -1]} it produces an empty list with negative numbers")
IO.inspect("#{Utils.range(-2, 2) == [-2, -1, -0, 1, 2]} it produces an empty list from negative numbers to positive numbers")