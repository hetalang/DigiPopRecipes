using CSV, DataFrames

## generate VP parameters of 1024, all log-normal for 
# Vc_0, kel, kdist_p, kdist_t, Emin_1, Emax_1, EC50_1
N_vp = 1024
parameters_df = DataFrame(
    Vc_0 = rand(Normal(log(5.5), 1e-1), N_vp) .|> exp,
    kel = rand(Normal(log(3e-1), 1e-1), N_vp) .|> exp,
    kdist_p = rand(Normal(log(7e-1), 1e-1), N_vp) .|> exp,
    kdist_t = rand(Normal(log(1e-2), 1e-1), N_vp) .|> exp,
    Emin_1 = rand(Normal(log(5.), 1e-1), N_vp) .|> exp,
    Emax_1 = rand(Normal(log(10.), 1e-1), N_vp) .|> exp,
    EC50_1 = rand(Normal(log(0.8), 1e-1), N_vp) .|> exp
)
CSV.write("data/01-multicompartment-pkpd/profile-1/vp-parameters-1.csv", parameters_df)
