using Test

# include("../src/Crossover.jl")
# inclide("../src/Types.jl")

include("../src/GeneticAlgorithms.jl")

using GeneticAlgorithms.Crossover 

@testset "Crossover.jl" begin
chromosome1 = [1, 2, 3, 4, 5]
chromosome2 = [6, 7, 8, 9, 10]

offspring1, offspring2 = singlePointCrossover(chromosome1, chromosome2)


flipped = false
isValid = true


for i in 1:length(offspring1)
    if offspring1[i] != chromosome1[i] && !flipped 
        flipped = true
        continue
    end

    if flipped && offspring1[i] != chromosome2[i]
        isValid = false
        break
    end

    if flipped && offspring1[i] != chromosome1[i]
        isValid = false
        break
    end
end

@test isValid

end 