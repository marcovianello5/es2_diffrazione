"""
Funzione generica per fittare con `LsqFit.jl` i punti sperimentali e verificare la qualità del fit.

# Argomenti:
- `model`: Solitamente il modello di malus (angolo in radianti).
- `x`: Solitamente il vettore degli angoli (in radianti).
- `y_exp`: Solitamente il vettore delle intensità misurate.
- `sigma::Real`: Solitamente l'incertezza che è stata assegnata ai valori di intensità.
- `p0`: Parametri iniziali
- `verbose::Bool`: Se `true` stampa un resoconto del fit.

# Ritorna:
- I risultati del fit (un oggetto di tipo `LsqFitResult`)
- Il numero di gradi di libertà.
- Il chi-squadro al minimo.
- il p-value.
"""

function fit_ols(m, x, y_exp, sigma::Real, p0; verbose=false)
    w = [1/sigma^2]

    fit = curve_fit(m, x, y_exp, w, p0)

    # Qualità del fit
    y_th = m(x, fit.param)
    resid = y_exp .- y_th  # Perché fit.resid ritorna i residui PESATI
    
    chisq_min = sum(w .* resid.^2)
    dof = length(y_exp) - length(fit.param)
    pvalue = ccdf(Chisq(dof), chisq_min)

    if verbose
        @show fit.param
        @show chisq_min
        @show dof
        @show pvalue
    end

    return fit, resid, dof, chisq_min, pvalue
end

"""
Funzione generica per fittare con `LsqFit.jl` i punti sperimentali e verificare la qualità del fit.
Lo scopo di questa versione è generare una lista di valori di chi-quadro al variare dell'incertezza sul valore di intensità.

# Argomenti:
- `model`: Solitamente il modello di malus (angolo in radianti).
- `x`: Solitamente il vettore degli angoli (in radianti).
- `y_exp`: Solitamente il vettore delle intensità misurate.
- `sigmas::AbstractVector{Real}`: Solitamente il vettore di incertezze assegnate ai valori di intensità.
- `p0`: Parametri iniziali

# Ritorna:
- I risultati del fit (un oggetto di tipo `LsqFitResult`)
- Il numero di gradi di libertà.
- Il chi-squadro al minimo.
- il p-value.
"""
function fit_ols(m, x, y_exp, sigmas::AbstractRange{<:Real}, p0)
    n = length(sigmas)

    chisq_mins = similar(sigmas)
    pvalues = similar(sigmas)

    for (i, sigma) in enumerate(sigmas)
        _, _, _, chisq_min, pvalue = fit_lsq(m, x, y_exp, sigma, p0)
        chisq_mins[i] = chisq_min
        pvalues[i] = pvalue
    end

    return chisq_mins, pvalues
end