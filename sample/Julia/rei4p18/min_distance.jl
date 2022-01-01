using JuMP
using SCS

function main()
    S = [2.0 4.0 5.0 1.0 3.0
         4.0 2.0 3.0 3.0 1.0]
    d, r = size(S)
    
    model = Model(SCS.Optimizer)
    @variables(model, begin 
        v[1:d]
        z[1:r]
    end)

    @objective(model, Min, sum(z))
    
    for l = 1:r
        @constraint(model, [z[l]; v .- S[:, l]] in SecondOrderCone())
    end

    print(model)
    optimize!(model)
    @show solution_summary(model)
    println(value.(v))
end

main()