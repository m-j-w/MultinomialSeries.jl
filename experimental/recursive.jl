# recursive.jl -- Part of 'Multinomials',
# a package for The Julia Programming Language
# Copyright (C) 2020-2021 Markus J. Weber
# License: See accompanying file 'LICENSE.md'


#=---- E X P E R I M E N T A L ----=#

"""
    map_multinomial(fn, m, n)

dims : m = dimension, > 0
order: n = order of application, ≥ 0
k = 1...m
Returns nothing.

Usage:
    map_multinomial(3,3) do k, Cₖₙ
        # This function is called for every combination of k
        # and the associated multinomial coefficient Cₖₙ.
        @show k, Cₖₙ
    end
"""
function map_multinomial(
            fn,
            dims::Integer, order::Integer,
            k::Union{Nothing,Array}=nothing
        )

    # Might quickly overflow !
    n_choose_k(n,k) = factorial(n) ÷ (factorial(k) * factorial(n-k))
        # Check validity of iterations
        #@info "number terms" n_choose_k(order+dims-1, dims-1) dims^order

    if k == nothing
        @boundscheck dims  > 0 || throw(ArgumentError("Multinomial requires positive dimension (>0). Given: $dims"))
        @boundscheck order ≥ 0 || throw(ArgumentError("Multinomial requires non-negative order (≥0). Given: $order"))
        # initial setup
        k = zeros(Int, dims)
    end

    if dims == 1
        k[1] = order
        Cₖₙ = factorial(sum(k)) ÷ prod(factorial.(k))       # Might quickly overflow !
        fn(k, Cₖₙ)
    else
        for kₘ in 0:order
            k[dims] = kₘ
            multinomial_generator(fn, dims-1, order-kₘ, k)
        end
    end

    nothing
end


# end of file
