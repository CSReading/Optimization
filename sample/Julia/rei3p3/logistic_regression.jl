using JuMP
using SCS
using LinearAlgebra
const MOI = SCS.MathOptInterface

function main()
    S = [-2.05 -1.20 -1.05 -0.82 -0.27 -0.28 0.03 0.50 0.82 1.12
         -0.35 2.90 -0.46 -1.57 0.70 1.09 -1.33 0.28 1.37 0.35]
    t = [1, -1, 1, 1, -1, -1, 1, -1, -1, 1]
    d, r = size(S)

    model = Model(SCS.Optimizer)
    @variables(model, begin
        w[1:d]
        v
        z[1:r]
    end)

    for l = 1:r
        u = -t[l] * (S[:, l]'w + v)
        softplus(model, z[l], u)
    end

    @objective(model, Min, sum(z))

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(w))
    println(value(v))
end

function softplus(model, t, u)
    z = @variable(model, [1:2], lower_bound = 0.0)
    @constraint(model, sum(z) ≤ 1.0)
    @constraint(model, [u - t, 1, z[1]] in MOI.ExponentialCone())
    @constraint(model, [-t, 1, z[2]] in MOI.ExponentialCone())
end

main() #Did not match with Python's!
