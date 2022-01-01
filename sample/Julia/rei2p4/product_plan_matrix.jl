using JuMP
using GLPK

function main()
    
    model = Model(GLPK.Optimizer)
    @variable(model, x[1:2] ≥ 0)

    c = [20.0, 60.0]
    G = [5.0 4.0
         2.0 4.0
         2.0 8.0]
    h = [80.0, 40.0, 64.0]

    @objective(model, Max, c'x)

    @constraint(model, G * x .≤ h)

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(x))
end

main()