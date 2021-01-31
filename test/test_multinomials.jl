# test_multinomial.jl -- Part of 'Multinomials',
# a package for The Julia Programming Language
# Copyright (C) 2020-2021 Markus J. Weber
# License: See accompanying file 'LICENSE.md'


#=----    Reference Sinusoid Solver Tests    ----=#

@testset "Standard Multinomials" begin

    @test collect(eachmultinomial(1,0)) == [(0,)]
    @test collect(eachmultinomial(2,2)) == [(2,0), (1,1), (0,2)]
    @test collect(eachmultinomial(2,3)) == [(3,0), (2,1), (1,2), (0,3)]
    @test collect(eachmultinomial(3,3)) == [
                (3, 0, 0), (2, 1, 0), (2, 0, 1), (1, 2, 0), (1, 1, 1),
                (1, 0, 2), (0, 3, 0), (0, 2, 1), (0, 1, 2), (0, 0, 3) ]

end


@testset "Automated consistency checks" begin

    for (m,n) in [ (1,0), (1,1), (1,2),
                   (2,2), (2,3), (2,4), (2,4),
                   (3,0), (3,1), (3,2), (3,3), (3,4), (3,5),
                   (4,0), (4,1), (4,2), (4,3), (4,4), (4,5),
                   (8,0), (8,1), (8,2), (8,3), (8,4), (8,5), 
                   (8,6), (8,7), (8,8), (8,9), (8,10), (8,12)
                ]

        it = eachmultinomial(m,n)
        xs = collect(it)
        @test   length(first(xs)) == m          # tuple length correct
        @test   length(xs) == length(it)        # theoretical number reached
        @test   all( sum(x) == n for x in xs )  # all add up to n
        @test   all( all(x .>= 0) for x in xs )  # all non-negative
        @test   unique(xs) == xs                # no duplicates in list

    end
            
end # testset


@testset "Result types" begin

    for t in (UInt8, Int8, UInt16, Int16, UInt32, Int32, UInt64, Int64, UInt128, Int128)

        @test collect(eachmultinomial(t, 1, 1))[1] isa Tuple{t}
        @test collect(eachmultinomial(t, 2, 2))[2] isa Tuple{t,t}
        @test collect(eachmultinomial(t, 3, 3))[3] isa Tuple{t,t,t}
    
        @test eltype(collect(eachmultinomial(t, 1, 1))) == Tuple{t}
        @test eltype(eachmultinomial(t, 1, 1)) == Tuple{t}
    end

end


@testset "Wrong function arguments" begin

    @test_skip #=DomainError=# collect(eachmultinomial( 0, 0))
    @test_skip #=DomainError=# collect(eachmultinomial(-1, 0))
    @test_skip #=DomainError=# collect(eachmultinomial( 1,-1))

    @test_skip #=TypeError=# collect(eachmultinomial(String, 1, 1))  # Only integer types
    @test_skip #=TypeError=# collect(eachmultinomial(BigInt, 1, 1))  # Only bits types, sorry.

end


# end of file