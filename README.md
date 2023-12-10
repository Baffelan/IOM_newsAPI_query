# IOM_newsAPI_query

[![Build Status](https://github.com/your-GitHub-username/IOM_newsAPI_query.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/your-GitHub-username/IOM_newsAPI_query.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Configuration
Before using this package ensure you have a key for [news API](https://www.newsapi.ai/):
```julia
ENV["NEWSAPIKEY"]="SecretKey"
```

# Usage
```julia
using IOM_newsAPI_query
using Dates


user = Dict("keywords"=>Dict("keywords"=>["amazon", "google"], "locations"=>"https://en.wikipedia.org/wiki/United_States", "languages"=>"eng"))

arts = query_newsapi(user, (today()-Day(2),today()), 5, "SocialScore")
```