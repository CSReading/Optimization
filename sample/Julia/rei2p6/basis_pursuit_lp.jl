using JuMP
using GLPK
using Random

function main()
    m, n = 5, 10
    Random.seed!(1)
    A, b = randn(m, n), randn(m)

    model = Model(GLPK.Optimizer)

    @variables(model, begin
        x[1:n]
        z[1:n]
    end)

    @objective(model, Min, ones(n)'z)

    @constraints(model, begin
        A * x .== b
        z .≥ x
        z .≥ -x
    end)

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(x))
end

main()