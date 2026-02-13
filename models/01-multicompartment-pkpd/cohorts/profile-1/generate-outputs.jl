using HetaSimulator, Plots
using CSV, DataFrames

## load model and scenarios and run mean

p = load_platform("models/01-multicompartment-pkpd")
pool_1 = read_scenarios("models/01-multicompartment-pkpd/scenarios/pool-1.csv")
add_scenarios!(p, pool_1)

#p |> sim |> plot

## load parameters and run simulations

parameter_set = read_mcvecs("data/01-multicompartment-pkpd/profile-1/vp-parameters-1.csv")

mc_res = mc(p, parameter_set)

mc_df = mc_res |> DataFrame
CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-personal-1.csv", mc_df)

fig = plot(mc_res)
savefig(fig, "data/01-multicompartment-pkpd/profile-1/vp-outputs-personal-1.png")

#ens = EnsembleSummary(mc_res; quantiles=[0.05,0.95])
#plot(ens)

long_df = stack(mc_df, [:drug_c, :pd_output_1], variable_name=:output)

# mean-sd format for DigiPopData.jl

df = combine(
    groupby(long_df, [:scenario, :output, :t]),
    [:output, :t] => ((x,y) -> string(x[1], "_", lpad(y[1] |> Int, 3, '0'))) => "endpoint",
    :value => mean => "metric.mean",
    :value => std  => "metric.sd",
)

df[!, "metric.type"] .= "mean_sd"
df[!, "id"] .= "m" .* lpad.(string.(1:nrow(df)), 3, '0')

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-mean_sd-1.csv", df)

## quartile format for DigiPopData.jl

levels = [0.25, 0.5, 0.75]
df = combine(
    groupby(long_df, [:scenario, :output, :t]),
    [:output, :t] => ((x,y) -> string(x[1], "_", lpad(y[1] |> Int, 3, '0'))) => "endpoint",
    :value => (x -> join(quantile(x, levels), ";")) => "metric.values",
)

df[!, "metric.levels"] .= join(levels, ";")
df[!, "metric.type"] .= "quantile"
df[!, "id"] .= "m" .* lpad.(string.(1:nrow(df)), 3, '0')

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-quartile-1.csv", df)

## quantile 10% format for DigiPopData.jl

levels = [0.1, 0.20, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
df = combine(
    groupby(long_df, [:scenario, :output, :t]),
    [:output, :t] => ((x,y) -> string(x[1], "_", lpad(y[1] |> Int, 3, '0'))) => "endpoint",
    :value => (x -> join(quantile(x, levels), ";")) => "metric.values",
)

df[!, "metric.levels"] .= join(levels, ";")
df[!, "metric.type"] .= "quantile"
df[!, "id"] .= "m" .* lpad.(string.(1:nrow(df)), 3, '0')

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-quantile-1.csv", df)
