using IOM_newsAPI_query
using Test

@testset "IOM_newsAPI_query.jl" begin
    query_newsapi(user, (today()-Day(1),today()-Day(2)), 1000)
end
