
# In: Location, keywords, date, language
# Out: Iterable of articles
function write_api_request(user, dates; sortby="SocialScore")
    kws = user["keywords"]
    
    locations = haskey(kws, "locations") ? kws["locations"] : nothing
    languages = haskey(kws, "languages") ? kws["languages"] : nothing

    keywords = haskey(kws, "keywords") ? kws["keywords"] : nothing
    concepts = haskey(kws, "concepts") ? kws["concepts"] : nothing
    sources = haskey(kws, "sources") ? kws["sources"] : nothing

    if all(isnothing.([keywords, concepts]))
        throw("Must have at least one of 'keywords', 'concepts', or 'sources'")
    end
    

    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            write_filter_query(dates, keywords=keywords, languages=languages, locations=locations, concepts=concepts, sources=sources)
            ),
        "articlesPage"=> "{\$}",
        "articlesCount"=> 100,
        "articlesSortBy"=> sortby,
        "articlesSortByAsc"=> false,
        "articlesArticleBodyLen"=> -1,
        "includeArticleSocialScore"=> true,
        "includeArticleLocation"=>true,
        "resultType"=> "articles",
        "apiKey"=>authentication()
    )
    return q
    
end
