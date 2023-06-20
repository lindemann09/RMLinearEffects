struct RMLinearRegression <: HypothesisTest
    formula::FormulaTerm
    linear_models::Vector
    subject_ids::Vector
    ttest::OneSampleTTest
end;

function fit(::Type{RMLinearRegression},
    f::FormulaTerm,
    data::DataFrame;
    sid::Union{Symbol,String})

    # repeated measures linear regression
    # individual regressions slopes
    regs = []
    slopes = Float64[]
    subject_ids = []
    for x in unique(data[:, sid])
        i = data[:, sid] .== x
        md = lm(f, data[i, :])
        push!(regs, md)
        push!(slopes, coef(md)[2])
        push!(subject_ids, x)
    end
    return RMLinearRegression(f, regs, subject_ids, OneSampleTTest(slopes))
end;


function fit(::Type{RMLinearRegression},
    data::DataFrame;
    dv::Union{Symbol,String},
    iv::Union{Symbol,String},
    sid::Union{Symbol,String})
    formula = term(dv) ~ term(1) + term(iv)
    return fit(RMLinearRegression, formula, data; sid)
end;

function pvalue(x::RMLinearRegression)
    return pvalue(x.ttest)
end

function regression_table(x::RMLinearRegression)
    regs = DataFrame(sid=Int[],
        intercepts=Float64[],
        slopes=Float64[],
        r2=Float64[])

    for (sid, md) in zip(x.subject_ids, x.linear_models)
        push!(regs, (sid, coef(md)[1], coef(md)[2], r2(md)))
    end
    return regs
end;

testname(::RMLinearRegression) = "Repeated Measures Linear Regressions: One sample t-test of regression slopes"
population_param_of_interest(x::RMLinearRegression) = population_param_of_interest(x.ttest)
show_params(io::IO, x::RMLinearRegression, ident="") = show_params(io, x.ttest, ident)