using JuMP
using Ipopt
using Random

function main()
    r = 20
    Random.seed!(1)
    A = hcat(ones(r), randn(r))
    c = A[:, 2]
    b = 10 * randn() * c .+ 0.5 * randn(r)

    model = Model(Ipopt.Optimizer)

    @variable(model, x[1:2])

    @objective(model, Min, sum(A * x - b).^2)

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(x))
end

main()