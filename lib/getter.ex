defmodule Getter do
    import HTTPotion
    import Poison
    @doc """
    Takes in a url string and returs the body or error with a status code
    """ 
    def get_body(url) do
        try do
            %HTTPotion.Response{body: body,headers: headers,status_code: status_code} = HTTPotion.get!(url)
            case status_code do
                200 -> {:ok,body}
                _-> {:error,status_code}
            end
        rescue
            _ in HTTPotion.HTTPError -> get_body(url)
            _ in ArgumentError -> {:error,"Argument Error"}
        end
    end


    @doc """
    Takes a {Symbol:Url} and returns a map or nil
    """
    def get_json_obj({symbol,url}) do
        try do 
            case get_body(url) do
                {:ok,body} -> case decode(body) do
                    {:ok,obj} -> {:ok,{symbol,obj}}
                    {:error,_} -> IO.puts symbol<>":"<>"JSON Parse Error"
                        {:error,nil}
                    end
                {:error,status_code} -> IO.puts symbol<> ":" <>"Returned an HTTP Error: "<>status_code
                    {:error,nil}
                end
        rescue
            _ in ArgumentError -> IO.puts symbol<>":"<>"Argument Error"
                {:error,nil}
            
        end
    end

    @doc """
    Take List Of URLS and return JSON bodies corresponding to them
    """
    def get_all_json(urls) do
        try do
            Enum.map(urls,fn(x) -> Task.async(get_json_obj(x)) end)
            |>Enum.map(fn(task) -> Task.await(task,200000) end)
        rescue
            _ -> {:error,"ERROR IN GET ALL"}   
       end
    end
end