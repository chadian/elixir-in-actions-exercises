# page 105

defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def add_entry(todo_list, item) do
    # add the id to the entry
    entry = Map.put(item, :id, todo_list.auto_id)

    # create new entries
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    # add new entries and auto increment the id on the struct in one swoop
    %TodoList {
      # existing todo_list
      todo_list |
      # modified properties on todo_list
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
      |> Stream.filter(fn {_id, item} ->
        item.date == date
      end)
      |> Enum.map(fn {_id, item} -> item end)
      # could be re-written in a terse, but less readable:
      # |> Enum.map(&(elem(&1, 1)))
  end

  def update_entry(todo_list, id, entry) do
    case Map.fetch(todo_list.entries, id) do
      :error ->
        todo_list

      {:ok, existing_entry} ->
        entry_with_id = Map.put(entry, :id, id)
        new_entries = Map.put(todo_list.entries, id, entry_with_id)

        %TodoList {
          todo_list |
          entries: new_entries
        }
    end
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

Test.it("can add and retrieve entries by date", fn() ->
  todo_list =
    TodoList.new() |>
      TodoList.add_entry(%{
        title: "Dentist",
        date: ~D[2018-12-19]
      }) |>
      TodoList.add_entry(%{
        title: "Shopping",
        date: ~D[2018-12-20]
      }) |>
      TodoList.add_entry(%{
        title: "Movies",
        date: ~D[2018-12-19]
      })

  Test.equals(
    TodoList.entries(todo_list, ~D[2018-12-19]),
    [
      %{
        id: 1,
        title: "Dentist",
        date: ~D[2018-12-19]
      },
      %{
        id: 3,
        title: "Movies",
        date: ~D[2018-12-19]
      }
    ]
  )
end)

Test.it("can update entries with the provided map", fn ->
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

  updated_todo_list = TodoList.update_entry(todo_list, 1, %{
    title: "Oh no, the dentist",
    date: ~D[2019-09-09]
  })

  Test.equals(
    Map.get(updated_todo_list.entries, 1),
    %{
      id: 1,
      title: "Oh no, the dentist",
      date: ~D[2019-09-09]
    }
  )
end)

Test.it("supports using an updater function with", fn ->
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

  non_existent_todo_id = 5

  unupdated_todo_list = TodoList.update_entry(todo_list, non_existent_todo_id, %{
    title: "Oh no, the dentist",
    date: ~D[2019-09-09]
  })

  Test.equals(
    todo_list,
    unupdated_todo_list
  )
end)

Test.it("returns the %TodoList when update_entry doesn't exist", fn ->
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

  non_existent_todo_id = 5

  unupdated_todo_list = TodoList.update_entry(todo_list, non_existent_todo_id, %{
    title: "Oh no, the dentist",
    date: ~D[2019-09-09]
  })

  Test.equals(
    todo_list,
    unupdated_todo_list
  )
end)
