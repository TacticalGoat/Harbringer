defmodule JSON do
    def get_attribute(obj,attribute) do
        Enum.at(Enum.at(obj["chart"]["result"],0)["indicators"]["quote"],0)[attribute]
    end

    def get_meta_attribute(obj,attribute) do
        Enum.at(obj["chart"]["result"],0)["meta"][attribute]
    end
end