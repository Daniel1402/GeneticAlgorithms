module Utils

using Plots

gr() # set gr backend

"""
Plots a contour of the function `f(x, y)` over the specified x and y ranges, with optional points highlighted.

# Arguments
- `f::Function`: The function to visualize.
- `x_range`: Range of x-values (default: (-2.0, 2.0)).
- `y_range`: Range of y-values (default: (-2.0, 2.0)).
- `points`: List of points to highlight (default: []).

# Returns
A contour plot of the function with optional highlighted points.
"""
function visualize_function_with_contours(
    f::Function;
    x_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    y_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    points::Vector{Tuple{Float64, Float64}} = []
)
    # generate function grid
    x = range(x_range[1], x_range[2], length=100)
    y = range(y_range[1], y_range[2], length=100)
    z = [f(xi, yi) for yi in y, xi in x]

    plt = contour(x, y, z, color=:viridis, linewidth=2)

    # add points
    if !isempty(points)
        indices = 1:length(points)  # Indices of the points
        colors = cgrad(:RdBu, length(x)).colors  # Generate a colormap
        scatter!(plt, [p[1] for p in points], [p[2] for p in points], color=colors[indices], marker=:circle, label="provided points")
    end

    return plt
end

export visualize_function_with_contours

end