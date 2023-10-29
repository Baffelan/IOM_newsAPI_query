
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

# arts = make_API_call(URL, q)

# arts = JSON.parse(arts)

# for i in 1:100
#     println(arts["articles"]["results"][i]["url"])
# end