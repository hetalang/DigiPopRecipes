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

# mean-sd format for DigiPopData.jl

dfs = []
for endpoint_name in [:drug_c, :pd_output_1]
    df = combine(
        groupby(mc_df, [:scenario, :t]),
        :t => (x -> string(endpoint_name, "_", lpad(x[1] |> Int, 3, '0'))) => "endpoint",
        endpoint_name => mean => "metric.mean",
        endpoint_name => std  => "metric.sd",
    )
    push!(dfs, df)
end
digipop_df = vcat(dfs...)

digipop_df[!, "metric.type"] .= "mean_sd"
digipop_df[!, "id"] .= "m" .* lpad.(string.(1:nrow(digipop_df)), 3, '0')
select!(digipop_df, Not(:t))

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-mean_sd-1.csv", digipop_df)

## quartile format for DigiPopData.jl

dfs = []
levels = [0.25, 0.5, 0.75]
for endpoint_name in [:drug_c, :pd_output_1]
    df = combine(
        groupby(mc_df, [:scenario, :t]),
        :t => (x -> string(endpoint_name, "_", lpad(x[1] |> Int, 3, '0'))) => "endpoint",
        endpoint_name => (x -> join(quantile(x, levels), ";")) => "metric.values",
    )
    push!(dfs, df)
end
digipop_df = vcat(dfs...)
digipop_df[!, "metric.levels"] .= join(levels, ";")
digipop_df[!, "metric.type"] .= "quantile"
digipop_df[!, "id"] .= "m" .* lpad.(string.(1:nrow(digipop_df)), 3, '0')
select!(digipop_df, Not(:t))

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-quartile-1.csv", digipop_df)

## quantile 10% format for DigiPopData.jl

dfs = []
levels = [0.1, 0.20, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
for endpoint_name in [:drug_c, :pd_output_1]
    df = combine(
        groupby(mc_df, [:scenario, :t]),
        :t => (x -> string(endpoint_name, "_", lpad(x[1] |> Int, 3, '0'))) => "endpoint",
        endpoint_name => (x -> join(quantile(x, levels), ";")) => "metric.values",
    )
    push!(dfs, df)
end
digipop_df = vcat(dfs...)
digipop_df[!, "metric.levels"] .= join(levels, ";")
digipop_df[!, "metric.type"] .= "quantile"
digipop_df[!, "id"] .= "m" .* lpad.(string.(1:nrow(digipop_df)), 3, '0')
select!(digipop_df, Not(:t))

CSV.write("data/01-multicompartment-pkpd/profile-1/vp-outputs-quantile-1.csv", digipop_df)

