function filter_userhaspermissions(article)
    filtered = article
    if "userHasPermissions" in keys(article)
        println("pinng")
        delete!(filtered, "userHasPermissions")
    end
    return filtered
end