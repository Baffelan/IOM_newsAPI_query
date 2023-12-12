
# In: Location, keywords, date, language
# Out: Iterable of articles
function write_api_request(user, dates; sortby="SocialScore")
    kws = user["keywords"]
    keywords = kws["keywords"]
    locations = kws["locations"]
    languages = kws["languages"]
    concept = kws["concept"]
    source = kws["source"]
    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            write_filter_query(dates, keywords=keywords, languages=languages, locations=locations, concept=concept, source=source)
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
