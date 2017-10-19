defmodule Indicators do
    import Utility
    import JSON
    defp zip_multiply({val1,val2}) do
        val1 * val2
    end
    def vwap(volume,close) do
        try do
            total_value = zip_apply(volume,close,&(zip_multiply(&1)))
                |> Enum.sum()
            total_volume = Enum.sum(volume)
            {:ok,total_value/total_volume}
        rescue
            _ in ArithmeticError -> {:error,"Arithmetic Error :("}
        end
    end

    def find_vwap_violation({symbol,obj},threshold) do
        if obj != nil do
            volume = get_attribute(obj,"volume")
            close = get_attribute(obj,"close")
            case vwap(volume,close) do
                {:ok,vwap} -> 
                    if abs(List.last(close) - vwap) - vwap >= threshold do
                        {true,symbol,vwap}
                    else
                        {false,symbol,vwap}
                    end
                {:error,reason} -> IO.puts symbol <>": "<> reason
                    {:error,symbol,reason}
            end
        else
            {:error,"NIL","JSON PARSE ERROR"}
        end
    end
end