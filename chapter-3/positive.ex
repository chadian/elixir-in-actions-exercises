# Create a positive/1 function that takes a list and returns another list
# that contains only the positive number from the input list
# page 91

defmodule Utils do
  def positive(list) do
    positive(list, [])
  end

  defp positive([], collection) do
    collection
  end

  defp positive([head | tail], collection) when head > 0 do
    positive(tail, [head | collection])
  end

  defp positive([head | tail], collection) when head <= 0 do
    positive(tail, collection)
  end
end

IO.inspect(Util.positive([-2, 4, 9, -9, 0, 2, 6, -3]))