# A list_len/1 function that calculates the length of
# a list.
# page 91

defmodule Utils do
  def list_len(list) do
    list_len_count(list, 0)
  end

  defp list_len_count([], count) do 
    count
  end

  defp list_len_count([_item|tail], count) do
    list_len_count(tail, count + 1)
  end
end

list = ["meow", "hello", "guten tag"]
IO.puts("With a list of three, #{Util.list_len(list) == length(list)}")

list = ["meow", "hello"]
IO.puts("With a list of two, #{Util.list_len(list) == length(list)}")

list = ["meow"]
IO.puts("With a list of one, #{Util.list_len(list) == length(list)}")

list = []
IO.puts("With an empty list, #{Util.list_len(list) == length(list)}")