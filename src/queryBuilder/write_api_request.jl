
# In: Location, keywords, date, language
# Out: Iterable of articles
function write_api_request(user, dates, sortby)
    kws = user["keywords"]
    keywords = kws["keywords"]
    locations = kws["locations"]
    languages = kws["languages"]
    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            write_filter_query(dates, keywords, languages=languages, locations=locations)
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
    
end
