# MultinomialSeries

Iterate over multinomial series expansions and compute corresponding
multinomial coefficients.

Status: In development, ready for public testing and comments.


## Motivation

Computing a power series or differentiation with respect to several variables
in a convenient iteration scheme.  Thus, an iterator is provided performing
the expansion

![Wikipedia Multinomial Theorem](https://wikimedia.org/api/rest_v1/media/math/render/svg/dccd561875a89864a7def8fbf7d8c9405234bbeb)

and computing the multinomial coefficients

![Wikipedia Multinomial Coefficients](https://wikimedia.org/api/rest_v1/media/math/render/svg/3c7165fdb93f8d28ab738a85570ce10529dcdad8)

The above equations are taken from the page [Multinomial Theorem (Wikipedia)](https://en.wikipedia.org/wiki/Multinomial_theorem)
giving further explanation and applications.


## Methods


    eachmultinomial(m,n)

Create an iterator over all expanded elements of the multinomial series.
Returns a tuple of the requested dimension `m`. The iterator type
`MultinomialIterator` provides length and element type information, see
`Base.length`, `Base.eltype`, `Base.IteratorSize` and `Base.IteratorEltype`.


    multinomial(k)

Compute the multinomial coefficient from a tuple k of integers, in the same
way as the elements of the iterator `eachmultinomial` provides.


### Example

```julia
for k in eachmultinomial(3,3)
    @show k, multinomial(k)
end

# printed output
(k, multinomial(k)) = ((3, 0, 0), 1)
(k, multinomial(k)) = ((2, 1, 0), 3)
(k, multinomial(k)) = ((2, 0, 1), 3)
(k, multinomial(k)) = ((1, 2, 0), 3)
(k, multinomial(k)) = ((1, 1, 1), 6)
(k, multinomial(k)) = ((1, 0, 2), 3)
(k, multinomial(k)) = ((0, 3, 0), 1)
(k, multinomial(k)) = ((0, 2, 1), 3)
(k, multinomial(k)) = ((0, 1, 2), 3)
(k, multinomial(k)) = ((0, 0, 3), 1)
```

## References

1. [Multinomial Theorem, Wikipedia](https://en.wikipedia.org/wiki/Multinomial_theorem)
2. [Multinomial Series, Wolfram MathWorld](https://mathworld.wolfram.com/MultinomialSeries.html)
3. [Multinomial, Wolfram Mathematica Reference](https://reference.wolfram.com/language/ref/Multinomial.html)
4. [SymPy 'multinomial_coefficients'](https://docs.sympy.org/latest/modules/ntheory.html?sympy.ntheory.multinomial.multinomial_coefficients_iterator#sympy.ntheory.multinomial.multinomial_coefficients)
  and [SymPy 'multinomial_coefficients_iterator', SymPy Manual, Chapter Number Theory](https://docs.sympy.org/latest/modules/ntheory.html?sympy.ntheory.multinomial.multinomial_coefficients_iterator#sympy.ntheory.multinomial.multinomial_coefficients_iterator)


## Contributions

Comments, feature requests and other contributions most welcome via the
[Github issue tracker or pull requests](https://github.com/m-j-w/MultinomialSeries.jl).
