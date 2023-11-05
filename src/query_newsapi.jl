"""
Writes and executes a query to the eventregistry articles API.
kws = user["keywords"]
keywords = kws["keywords"]
locations = kws["locations"]
languages = kws["languages"]
# Arguments
- `user::Dict`: Built to be compatible with the `user` table. It must have the field "keywords"=>Dict()...
"""

function query_newsapi(user, dates, num_articles)

    query_str = write_api_request(user, dates)
    res_pg_1 = execute_query(query_str, authentication(),1) # Query 1 first, as it returns the total number of articles from a query

    num_pages = calculate_pages(res_pg_1, num_articles)

    res_pgs = execute_query.([query_str],[authentication()], 2:num_pages) # In future, this might be parralellised
    vcat(res_pg_1["articles"]["results"], [res["articles"]["results"] for res in res_pgs]...)
    # URL = "http://eventregistry.org/api/v1/article/getArticles"

end


