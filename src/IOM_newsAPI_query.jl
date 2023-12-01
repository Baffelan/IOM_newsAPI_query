module IOM_newsAPI_query
    using HTTP
    using JSON
    using Dates
    
    include("queryBuilder/action.jl")
    include("queryBuilder/authentication.jl")
    include("queryBuilder/calculate_pages.jl")
    include("queryBuilder/execute_query.jl")
    include("queryBuilder/write_api_request.jl")
    include("queryBuilder/write_filter_query.jl")

    include("filter_userhaspermissions.jl")
    include("query_newsapi.jl")

    export query_newsapi
end
