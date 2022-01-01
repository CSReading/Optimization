using JuMP
using Ipopt
using Random

function main()
    m, n, γ = 10, 5, 100.0
    Random.seed!(2)

    A = randn(m, n)
    b = 100 * randn(m)

    model = Model(Ipopt.Optimizer)

    @variables(model, begin
        x[1:n]
        z[1:n]
    end)

    @objective(model, Min, sum(A * x - b).^2 + γ * sum(z))

    @constraints(model, begin
        z .≥ x
        z .≥ -x
    end)

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(x))
end

main()