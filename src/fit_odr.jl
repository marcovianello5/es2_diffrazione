"""
Funzione generica per fittare con `Odrpack.jl` i punti sperimentali e verificare la qualità del fit.

# Argomenti:
- `m!`: Solitamente il modello di malus (angolo in radianti).
- `x`: Solitamente il vettore degli angoli (in radianti).
- `y_exp`: Solitamente il vettore delle intensità misurate.
- `sigma::Real`: Solitamente l'incertezza che è stata assegnata ai valori di intensità.
- `p0`: Parametri iniziali
- `verbose::Bool`: Se `true` stampa un resoconto del fit.

# Ritorna:
- diocane
"""

function fit_odr(m!, x, y_exp, sigmax, sigmay::Real, p0; verbose=false)
    wx = 1/sigmax^2
    wy = 1/sigmay^2

    sol = odr_fit(m!, x, y_exp, p0; weight_x=wx, weight_y=wy)

    # Qualità del fit
    chisq_min = sol.sum_square
    dof = length(intden_exp) - length(fit.param)
    pvalue = ccdf(Chisq(dof), chisq_min)
    
    if verbose
        @show sol.beta
        @show chisq_min
        @show dof
        @show pvalue
    end

    return sol, sol.eps, dof, chisq_min, pvalue
end

function fit_odr(m!, x, y_exp, sigmax, sigmays::AbstractRange{<:Real}, p0)
    
    n = length(sigmays)

    chisq_mins = similar(sigmays)
    pvalues = similar(sigmays)

    for (i, sigmay) in enumerate(sigmays)
        _, _, _, chisq_min, pvalue = fit_odr(m!, x, y_exp, sigmax, sigmay, p0)
        chisq_mins[i] = chisq_min
        pvalues[i] = pvalue
    end

    return chisq_mins, pvalues
end


