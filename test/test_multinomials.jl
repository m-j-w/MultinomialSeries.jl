# test_multinomial.jl -- Part of 'Multinomials',
# a package for The Julia Programming Language
# Copyright (C) 2020-2021 Markus J. Weber
# License: See accompanying file 'LICENSE.md'


#=----    Reference Sinusoid Solver Tests    ----=#

#@testset "Multinomial" begin

    function collect_multinomial(m,n)
        a = []
        add_term(x,y) = (print("."); push!(a, (x,y)))
        multinomial_generator(add_term, m, n)
        return a
    end

    # specific tests for well known cases
    # 1) (a,b)²
    xs = collect_multinomial(2,2)
    println(xs)
    # 2) (a,b,c)³


    # generic consistency checks:
    # 1) number of resulting terms matches ?
    # 2) sum of all coefficients matches ?
    # 3) no duplicated coefficient packs


    #@test ...

#end # testset


# end of file