defmodule TodoTest do
  use ExUnit.Case
  doctest Todo

  test "defines a struct with number, title, due date and done" do
    todo = %Todo{number: 1, title: "Write tests", due_date: NaiveDateTime.utc_now()}

    assert todo.done == false
  end

end
