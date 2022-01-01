using JuMP
using GLPK

function main()
    model = Model(GLPK.Optimizer)
    @variables(model, begin
        x₁ ≥ 0
        x₂ ≥ 0
    end)

    @objective(model, Max, 20x₁ + 60x₂)

    @constraints(model, begin
        5x₁ + 4x₂ ≤ 80
        2x₁ + 4x₂ ≤ 40
        2x₁ + 8x₂ ≤ 64
    end)

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println("$(value.(x₁)) $(value.(x₂))")
end

main()