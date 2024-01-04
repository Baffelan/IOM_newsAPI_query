"""
Splits long lists of keywords into smaller batches and runs a query on each batch. Then rejoins them back into one DataFrame. When this happens, the `relevance` column will not be as useful, as the external API does not know the full query. 
kws = user["keywords"]
keywords = kws["keywords"]
locations = kws["locations"]
languages = kws["languages"]
concepts = kws["concepts"]
sources = kws["sources"]
# Arguments
- `user::Dict`: Built to be compatible with the `user` table. It must have the field "keywords"=>Dict("keywords", "locations", "languages") (TODO: Remove explicit need for languages fields, consider keeping keywords and locations to prevent accidentally querying large numbers of results.)
- `dates::Tuple{Date}`: (startDate, endDate) of query.
- `num_articles::Int`: Maximum number of articles queried (rounded up to nearest 100 as there are 100 articles per page and each query costs the same). 
- `sortby::String`: The value to sort article return order by.
"""
function query_newsapi(user::Dict, dates::Tuple{Date, Date}, num_articles::Int, sortby::String; debug=false)
    kws = user["keywords"]
    batches = split_keywords(kws["keywords"])
    users = [deepcopy(user) for _ in batches]
    for (i, b) in enumerate(batches)
        users[i]["keywords"]["keywords"]=b
    end
    arts = query_newsapi_helper.(users, [dates], [num_articles], [sortby], debug=debug)
    all_arts = vcat(arts...) 

    return unique([a for a in all_arts if typeof(a)<:Dict])
end


