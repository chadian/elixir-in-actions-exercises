# page 105

defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, date, item) do
    MultiDict.add(todo_list, date, item)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], fn previous -> [value | previous] end)
  end

  def get(dict, key) do
    Map.get(dict, key)
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

Test.it("can add and retrieve entries by date", fn() ->
  todo_list =
    TodoList.new() |>
      TodoList.add_entry(~D[2018-12-19], "Dentist") |>
      TodoList.add_entry(~D[2018-12-20], "Shopping") |>
      TodoList.add_entry(~D[2018-12-19], "Movies")

  Test.equals(TodoList.entries(todo_list, ~D[2018-12-19]), ["Movies", "Dentist"])
end)
