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

# Data Structure
| Variable | Type | Description | Example |
| -------- | ---- | ------------------ | --- |
| time     | String | time newsapi.ai found the article in UTC timezone | 11:40:00 |
| dataType | String | type of the article (news, blog, or pr) | "news" |
| eventUri | String | event URI to which the article is assigned to (if any) | "eng-2320588" |
| shares | JSON | The shares on various platforms | {"facebook": 1, "pinterest:" 2} |
| location | JSON | was there explicit location extracted from dateline? | {"label": {"eng": "Boston"}, "type": "place",  {"country": {"label": {"eng": "United States"}, "type": "country"} |
| wgt | Int | parameter used internally for sorting purposes (DO NOT USE THE VALUE) | 12341243 |
| isDuplicate | Bool | is article a duplicate of another article? | false |
| sim | Float | cosine similarity of the article to the centroid of the story | 0.3906 | 
| body | String | article's full body | "As Phil Schiliro arrived at his first meeting last ..."
| image | String | article's image | "https://cdn.arstechnica.net/wp-content/uploads/2013/07/you-slow.jpg" |
| sentiment | Float | sentiment of the article (can be null if value is not set). Between -1 (very negative) and 1 (very positive) | -0.2 |
| date | Date | date newsapi.ai found the article in UTC timezone | 2013-12-18 |
| url | String | web url of the article | "http://www.Newsmax.com/Newsfront/obama-staff-veterans-revamp/2013/12/18/id/542478" |
| uri | String | article's URI (unique article's ID - not necessarily a number) | "143701955" |
| relevance | Int | relevance represents how well does the article match the query - the higher the value, the better the match. If search results are sorted by relevance, this is the value used for sorting | 34 |
| dateTimePub | DateTime | the datetime provided in the RSS feed or in article's metadata. The value chosen is the value closest to the datetime when the article was identified. The value is not monotonically increasing as the articles are added to Event Registry | 2013-12-18T11:12:00Z |
| source | JSON | details about the news source (see Source data model) | {"uri": "boston.com", "dataType": "news", "title": "Boston"} |
| lang | String | language of the article | "eng" |
| title | String | article's title | "Desperate Obama Tries to Reset Agenda with New Staff"
| dateTime | DateTime | datetime when we found and serialized the article in UTC timezone. Each next article added to Event Registry will have a higher value | 2013-12-18T11:40:00Z |
| authors | JSON | list of article's authors | [{"uri": "john_doe@techcrunch.com", "name":"John Doe", "type":"author", "isAgency": false},...] |
| TODO: categories | TODO | TODO | TODO |
