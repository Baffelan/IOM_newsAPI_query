"""
Runs the a query to the eventregistry article api. Returns a dictionary of the response body.

# Arguments
- `q::Dict`: A dictionary containing the query. The dictionay is parsed to a JSON string as it is sent to the API.
- `key::String`: API key.
- `page::Int`: The page that is queried from the API. Each page contains 100 articles.
"""
function execute_query(q, key, page)
    URL = "http://eventregistry.org/api/v1/article/getArticles"


    headers = Dict("Content-Type"=> "application/json","apiKey"=>key)
    paged_query = replace(JSON.json(q), "{\$}"=>string(page))
    try
        response = HTTP.get(URL, headers, paged_query)
        return JSON.parse(String(response.body))
    catch e
        return e
    end
end
