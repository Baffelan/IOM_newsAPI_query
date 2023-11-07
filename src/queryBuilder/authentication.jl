function authentication()
    try
        ENV["NEWSAPIKEY"]
    catch e
        throw(e)
    end
end