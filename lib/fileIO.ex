defmodule FileIO do
    @moduledoc """
    All File I/O functions
    """
    @doc """
    Takes input path and returns :ok, contents
    seperated by newline in a collection
    or returns :error,reason
    """
    def read_symbols(file) do
        if File.exists?(file) do
            output = File.read!(file)
                     |> String.split("\n")
            {:ok,output}
        else
            {:error,"Symbols File Does not Exist!"}
        end
    end
end