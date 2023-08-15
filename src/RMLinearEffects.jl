module RMLinearEffects

using DataFrames
using HypothesisTests
using GLM

import CategoricalArrays: unique
import StatsAPI: fit
import HypothesisTests: pvalue,
        show_params,
        testname,
        population_param_of_interest,
        HypothesisTest

export RMLinearRegression,
        fit,
        regression_table,
        pvalue,
        population_param_of_interest,
        show_params,
        # permute
        @formula # reexport

include("rmlm.jl")

end; # module