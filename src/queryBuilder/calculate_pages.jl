function calculate_pages(result, max_articles)
    if length(result)!=0
        pages = ceil(min(result["articles"]["totalResults"],max_articles)//100) # 100 is the number of articles on each page
        return convert(Int, pages)
    else
        return 0
    end
end
