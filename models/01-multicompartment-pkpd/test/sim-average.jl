using HetaSimulator
using Plots

p = load_platform("models/01-multicompartment-pkpd")
m = p.models[:nameless]

res = Scenario(m, (0., 120.)) |> sim

plot(res; vars = [:drug_gut, :drug_c])
plot(res; vars = [:drug_t, :pd_output_1])
