"""
Writes and executes a query to the eventregistry articles API.
kws = user["keywords"]
keywords = kws["keywords"]
locations = kws["locations"]
languages = kws["languages"]
# Arguments
- `user::Dict`: Built to be compatible with the `user` table. It must have the field "keywords"=>Dict("keywords", "locations", "languages") (TODO: Remove explicit need for languages fields, consider keeping keywords and locations to prevent accidentally querying large numbers of results.)
- `dates::Tuple{Date}`: (startDate, endDate) of query.
- `num_articles::Int`: Maximum number of articles queried (rounded up to nearest 100 as there are 100 articles per page and each query costs the same). 
- `sortby::String`: The value to sort article return order by.
"""
function query_newsapi(user::Dict, dates::Tuple{Date, Date}, num_articles::Int, sortby::String; debug=false)

    query_str = isnothing(sortby) ? write_api_request(user, dates) : write_api_request(user, dates, sortby=sortby)
    if debug
        println(JSON.json(query_str))
    end
    res_pg_1 = execute_query(query_str, authentication(),1) # Query 1 first, as it returns the total number of articles from a query

    num_pages = calculate_pages(res_pg_1, num_articles, debug=debug)

    res_pgs = execute_query.([query_str],[authentication()], 2:num_pages) # In future, this might be parralellised
    
    all_pages = vcat(res_pg_1["articles"]["results"], [res["articles"]["results"] for res in res_pgs]...)

    filtered = filter_userhaspermissions.(all_pages)
    min_idx = min(length(filtered),num_articles)
    return filtered[1:min_idx]
end


