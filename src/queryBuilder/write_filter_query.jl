"""
Constructs the logic of the query. That is, the section of the newsAPI request that filters for keywords, dates, etc.

TODO:
    add better defaults to kwargs


# Arguments
- `dates::Tuple{Date}`: A tuple containing the start and end date of the query. This is not an optional argument to prevent accidentally querying far in the past, which is extremely expensive.
- 
"""
# function write_filter_query(dates, keywords; languages=nothing, locations=nothing)
#     "\$query"=> Dict(
#                 "\$and"=> [Dict(
#                     [u for u in Dict("locationUri"=>locations, "lang"=>languages) if !isnothing(u[2])]...,  # HACK: should be functionalised for clarity
#                     "dateStart"=> "$(dates[1])",
#                     "dateEnd"=> "$(dates[2])"
#                 ),
#                 "\$or"=>[Dict(
#                 "keyword"=> Dict("\$or"=>keywords))]]
#             )
# end

filter_nothings(A) = [a for a in A if !isnothing(a[2]["\$or"])]

function write_filter_query(dates::Tuple{Date, Date}; languages=nothing, locations=nothing, keywords=nothing, concepts=nothing, sources=nothing)

    "\$query"=> Dict(
                "\$and"=> [
                    Dict(
                    [u for u in Dict("locationUri"=>locations, "lang"=>languages) if !isnothing(u[2])]...,  # HACK: should be functionalised for clarity
                    "dateStart"=> "$(dates[1])",
                    "dateEnd"=> "$(dates[2])"
                ),

                "\$or"=>[filter_nothings(["keyword"=>Dict("\$or"=>keywords),
                "conceptUri"=>Dict("\$or"=>concepts),
                "sourceUri"=>Dict("\$or"=>sources)])...]
                
                ]
            )
end


