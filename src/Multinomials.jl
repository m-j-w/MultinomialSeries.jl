# Multinomials.jl -- Part of 'Multinomials',
# a package for The Julia Programming Language
# Copyright (C) 2020-2021 Markus J. Weber
# License: See accompanying file 'LICENSE.md'


module Multinomials

export multinomial, eachmultinomial

import Base: eltype, iterate, length,
             IteratorSize, IteratorEltype

using StaticArrays: MVector


struct MultinomialIterator{T,N,P} end

eachmultinomial(dims, order) = MultinomialIterator{Int,dims,order}()
eachmultinomial(::Type{T}, dims, order) where T<:Integer = MultinomialIterator{T,dims,order}()

multinomial(k::NTuple{N,T}) where {N,T} = T(factorial(sum(k)) ÷ prod(factorial.(k)))


# See https://en.wikipedia.org/wiki/Multinomial_theorem?section=5#Number_of_multinomial_coefficients
# here: P ≡ m, N ≡ m
Base.length(::MultinomialIterator{T,N,P}) where {T,N,P} = binomial(P+N-1, N-1)

Base.eltype(::MultinomialIterator{T,N,P}) where {T,N,P} = NTuple{N,T}

Base.IteratorSize(::MultinomialIterator) = Base.HasLength()
Base.IteratorEltype(::MultinomialIterator) = Base.HasEltype()

# iterate impementation note:
# State is a MVector of k₁...kₘ (m=N), plus a pointer to the current active iteration element in k.
# The element data type returned is a NTuple{N,T}, which is simply pulled out from the MVector.
function Base.iterate(
        ::MultinomialIterator{T,N,P}    
    ) where {T,N,P}

    local k::NTuple{N,T} = (T(P), (zero(T) for n in 1:N-1)...)
    return ( k,                      # element
            (MVector{N,T}(k), 1) )   # state

end

function Base.iterate(
        ::MultinomialIterator{T,N,P},
        state    
    ) where {T,N,P}

    k, ptr = state

    while @inbounds k[ptr] == 0
        ptr -= 1
        P == 0 && ptr == 0 && @goto finish  # only relevant if order == 0
    end

    if ptr == N  # ==length(k)
        while true
            ptr == 1 && @goto finish        # done !
            ptr -= 1                                
            @inbounds k[ptr] == 0 || break
        end
        @inbounds balls = sum(k[ptr+1:end])
        @inbounds k[ptr+1:end] .= 0         # reset everything after current position to zero
        @inbounds k[ptr+1] += balls
    end

    if @inbounds k[ptr] > 0
        @inbounds k[ptr] -= 1
        @inbounds k[ptr += 1] += 1
    end

    return (k.data, (k, ptr))

    @label finish
    return nothing

end  # function iterate


end  # module Multinomials


# end of file


# tests

using .Multinomials

it = eachmultinomial(3,3)

println("Length ", length(it))

for ks in it
    println(ks)
end
