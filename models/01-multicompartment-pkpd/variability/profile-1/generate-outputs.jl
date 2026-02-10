using HetaSimulator
using CSV, DataFrames

p = load_platform("models/01-multicompartment-pkpd")

pool_1 = read_scenarios("models/01-multicompartment-pkpd/scenarios/pool-1.csv")
add_scenarios!(p, pool_1)

#p |> sim |> plot # just for test

parameter_set = read_mcvecs("models/01-multicompartment-pkpd/variability/profile-1/vp-1.csv")

mc_res = mc(p, parameter_set)
plot(mc_res)

ens = EnsembleSummary(mc_res; quantiles=[0.05,0.95])
plot(ens)

mc_df = mc_res |> DataFrame

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-1.csv", mc_df)