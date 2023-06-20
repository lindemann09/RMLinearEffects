module RMLinearEffects

using DataFrames
using HypothesisTests
using GLM

import StatsAPI: fit
import HypothesisTests: pvalue,
        show_params,
        testname,
        population_param_of_interest,
        HypothesisTest

export RMLinearRegression,
        rmlm,
        fit,
        regression_table,
        pvalue,
        # permute
        @formula # reexport

include("rmlm.jl")

end; # module