function calculate_pages(result, max_articles)
    pages = ceil(min(result["articles"]["totalResults"],max_articles)//100) # 100 is the number of articles on each page
    return convert(Int, pages)

end
