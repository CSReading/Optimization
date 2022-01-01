using JuMP
using SCS

function main()
    m, n, γ = 10, 5, 0.1
    Random.seed!(1)
    A, b = randn(m, n), 10 * randn(m)
    
    model = Model(SCS.Optimizer)
    @variables(model, begin 
        x[1:n]
        z
        w[1:n]
    end)

   @objective(model, Min, z + γ * sum(w))
   @constraints(model, begin
        [z; A * x .- b] in SecondOrderCone()
        w .≥ -x
        w .≥ x
    end)


    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(x))
end

main()