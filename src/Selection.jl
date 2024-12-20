module Selection

using ..Types

struct RouletteWheelSelection <: SelectionMethod end

"""
Performs Roulette Wheel Selection on a population based on fitness scores, returning two selected individuals (parents).

Selection is based on the cumulative probabilities of the fitness scores. 
"""
function (c::RouletteWheelSelection)(population::Population{T}, fitness_scores::Vector{Float64}, rand_generator::Function=rand)::Tuple{T,T} where {T<:Chromosome}
    if size(population.chromosomes, 1) != length(fitness_scores)
        throw(ArgumentError("Population and fitness scores must have the same length"))
    end

    if size(population.chromosomes, 1) <= 1
        throw(ArgumentError("Population must have at least 2 individuals"))
    end

    if any(fitness_scores .< 0)
        throw(ArgumentError("Fitness scores must be non-negative"))
    end

    if all(fitness_scores .== 0.0)
        throw(ArgumentError("Fitness scores cannot all be zero"))
    end

    if size(population.chromosomes, 1) == 2
        return population.chromosomes[1], population.chromosomes[2]
    end

    # Helper function to select an index based on the fitness scores
    function indexSelection(fitness_scores, rand_generator)
        # Calculate the cumulative probabilities
        cum_probs = cumsum(fitness_scores ./ sum(fitness_scores))

        fixed_rand = rand_generator()

        selected_index = findfirst(cum_prob -> fixed_rand <= cum_prob, cum_probs)

        return isnothing(selected_index) ? length(fitness_scores) : selected_index
    end

    p1_index = indexSelection(fitness_scores, rand_generator)

    # Filter out the selected index & search for the second parent
    p2_index = indexSelection(fitness_scores[1:end.!=p1_index], rand_generator)

    # Adjust the index to account for the removed element
    p2_index += (p2_index >= p1_index ? 1 : 0)

    return population.chromosomes[p1_index], population.chromosomes[p2_index]
end


export RouletteWheelSelection
end
