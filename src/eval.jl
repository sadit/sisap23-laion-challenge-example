function evalresults(resultfiles, gfile, k)
    gold_knns = jldopen(f->f["knns"][1:k, :], gfile)
    res = (data=[], size=[], algo=[], buildtime=[], querytime=[], params=[], recall=[])
    for resfile in resultfiles
        @info resfile
        reg = jldopen(resfile) do f
            knns = f["knns"][1:k, :]
            recall = macrorecall(gold_knns, knns)
            (f["data"], f["size"], f["algo"], f["buildtime"], f["querytime"], f["params"], recall)  # aligned with res
        end

        for i in eachindex(reg)
            push!(res[i], reg[i])
        end
    end

    res
end
