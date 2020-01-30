# page 105

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def add_entry(todo_list, item) do
    # MultiDict.add(todo_list, item.date, item)

    # add the id to the entry
    entry = Map.put(item, :id, todo_list.auto_id)

    # create new entries
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    # add entries to new todo_list
    new_todo_list = Map.put(todo_list, :entries, new_entries)
      # and increment the id
      |> Map.put(:auto_id, todo_list.auto_id + 1)

    new_todo_list
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

defmodule Test do
  def it(title, fun) do
    IO.inspect("it " <> title)
    fun.()
  end

  def equals(a, b) do
    IO.inspect(a == b)
  end
end

Test.it("can add entries with an incrementing id", fn() ->
  todo_list =
    TodoList.new() |>
      TodoList.add_entry(%{
        title: "Dentist",
        date: ~D[2018-12-19]
      }) |>
      TodoList.add_entry(%{
        title: "Shopping",
        date: ~D[2018-12-20]
      })

  Test.equals(Map.get(todo_list.entries, 1), %{
    id: 1,
    title: "Dentist",
    date: ~D[2018-12-19]
  })

  Test.equals(Map.get(todo_list.entries, 2), %{
    id: 2,
    title: "Shopping",
    date: ~D[2018-12-20]
  })
end)

# Test.it("can add and retrieve entries by date", fn() ->
#   todo_list =
#     TodoList.new() |>
#       TodoList.add_entry(%{
#         title: "Dentist",
#         date: ~D[2018-12-19]
#       }) |>
#       TodoList.add_entry(%{
#         title: "Shopping",
#         date: ~D[2018-12-20]
#       }) |>
#       TodoList.add_entry(%{
#         title: "Movies",
#         date: ~D[2018-12-19]
#       })

#   Test.equals(
#     TodoList.entries(todo_list, ~D[2018-12-19]),
#     [
#       %{
#         title: "Movies",
#         date: ~D[2018-12-19]
#       },
#       %{
#         title: "Dentist",
#         date: ~D[2018-12-19]
#       }
#     ]
#   )
# end)
