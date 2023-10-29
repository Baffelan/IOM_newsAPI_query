
# In: Location, keywords, date, language
# Out: Iterable of articles
function write_query(user, dates)
    kws = user["keywords"]
    keywords = kws["keywords"]
    locations = kws["locations"]
    languages = kws["languages"]
    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            "\$query"=> Dict(
                "\$and"=> [Dict(
                    "dateStart"=> "$(dates[1])",
                    "dateEnd"=> "$(dates[2])"
                ),
                "\$or"=>[Dict(
                "keyword"=> Dict("\$or"=>keywords))]]
            )
            ),
        "articlesPage"=> "\{\$\}",
        "articlesCount"=> 100,
        "articlesSortBy"=> "socialScore",
        "articlesSortByAsc"=> false,
        "articlesArticleBodyLen"=> -1,
        "includeArticleSocialScore"=> true,
        "resultType"=> "articles",
        "apiKey"=>authentication()
    )
    
end