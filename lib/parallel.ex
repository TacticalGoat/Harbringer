defmodule Parallel do
    @moduledoc """
    This module contains all generic Parallel functions
    Example: Parallel Map i,e. pmap/2
    """

    @doc """
    A Parallelised map function using Task.async/1
    Takes a collection and function and an optional limit
    Returns collection
    """
    def pmap(collection,func,limit \\ 5000) do
        IO.puts "PMAP BEGUN"
        answer = collection
                 |> Enum.map(fn(x) -> Task.async(fn -> func.(x) end) end)
        IO.puts "PMAP DONE"
        Enum.map(answer,&Task.await(&1,limit))
    end
end