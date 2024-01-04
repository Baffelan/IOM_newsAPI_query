"""
A function to split a long list of keywords into multiple, each below the maximum limit of 60. This is the total number of words in the query, not the number of phrases used, for example "amazon warehouse" is one phrase, but will count as 2 words.

# Arguments
- `kws::Vector{String}`: The vector of keywords being queried on.
"""
function split_keywords(kws::Vector{String})
    MAX_WORDS = 60
    split_num=0
    splits=[]
    cur_split=[]
    for w in kws
        w_count = 1+count(i->(i==' '), w)

        if w_count > MAX_WORDS
            throw("One of the key phrases exceeds the word limit of $(MAX_WORDS)")
        end

        if split_num + w_count <= MAX_WORDS
            split_num = split_num + w_count
            push!(cur_split, w)
        else 
            push!(splits, cur_split)
            cur_split = [w]
            split_num = w_count
        end
    end
    push!(splits, cur_split)
    return splits
end

