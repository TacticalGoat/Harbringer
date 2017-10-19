defmodule Utility do
    import Parallel
    @moduledoc """
    Helper Functions
    """

    @doc """
    applies fuction to two collections element by element
    Collections must be same size
    Returns Collection
    """
    def zip_apply(collection1,collection2,func) do
        Enum.zip(collection1,collection2)
        |>Enum.map(func)
    end

    @doc """
    Concurrent Version of Utility.zip_apply/3
    Applies function to two collections element by element
    Collections must be same size
    Returns Collection 
    """
    def zip_apply_parallel(collection1,collection2,func) do
        Enum.zip(collection1,collection2)
        |>pmap(func)
    end

    @doc """
    Generates daily URL for partner-query
    """
    def generate_daily_url(symbol) do
        {symbol,"https://partner-query.finance.yahoo.com/v8/finance/chart/"<>symbol<>".NS?range=1d&interval=1m"}
    end
end