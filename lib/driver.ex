defmodule Driver do
    import FileIO
    import Parallel
    import Utility
    import Getter
    import Indicators
    def main do
        case read_symbols("./lib/symbols.bin") do
            {:ok,symbols} -> Enum.map(symbols,&(generate_daily_url(&1)))
                |>Getter.get_all_json()
                |>Enum.map(fn(x) ->
                    find_vwap_violation(x,0.38)
                    end)
                |>print_vwap_violators
            {:error,reason} -> IO.puts "ERROR: "<> reason
        end
    end

    defp print_vwap_violators({result,name,value}) do
        case result do
            true -> IO.puts name <> ": " <> value
            :error -> IO.puts name <> ": "<> value <> " Reported Error Check for Removal"
            _ -> :ok
        end
    end
end