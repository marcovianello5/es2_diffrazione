"""
Da scrivere

# Argomenti:
- diocane

# Ritorna:
- diocne
"""

function plot_chisq_mins(sigmas, dof, chisq_mins, pvalues; verbose=false)
    # Determino i punti ottimi

    s = 2 * sqrt(2 * dof)  # Erorre sulla media del χ²

    j0 = argmin(abs.(chisq_mins .- dof))
    sigma0 = sigmas[j0]
    chisq_min0 = chisq_mins[j0]
    pvalue0 = pvalues[j0]

    j1 = argmin(abs.(chisq_mins .- dof .- s))
    sigma1 = sigmas[j1]
    chisq_min1 = chisq_mins[j1]
    pvalue1 = pvalues[j1]

    if verbose
        @show j0
        @show sigma0
        @show chisq_min0
        @show pvalue0

        @show j1
        @show sigma1
        @show chisq_min1
        @show pvalue1
    end

    # Plotto i chisq_min
    chisq_mins_plot = plot()

    plot!(chisq_mins_plot, sigmas, chisq_mins, label="")  # Incertezza vs. chi-quadro

    # Plotto la barra a 1σ
    lower = dof - s
    upper = dof + s
    label_text = "1σ della media di χ² ≈ ±$(s)"
    hline!(chisq_mins_plot, [lower], fillrange=upper, fillalpha=0.25, fillcolor=:green, linealpha=0, label=label_text)

    hline!(chisq_mins_plot, [dof], label="gradi di libertà: $(dof)", c=:red, alpha=0.4)  # Numero di gradi di libertà

    scatter!(chisq_mins_plot, [sigma0], [chisq_min0], label="", c=:red)  # Punto su p-value ottimo
    scatter!(chisq_mins_plot, [sigma1], [chisq_min1], label="", c=:orange)  # Punto su p-value a -σ

    # Plotto i p-value
    pvalues_plot = plot()

    plot!(pvalues_plot, sigmas, pvalues, label="") # Incertezza vs. p-value
    
    hline!(pvalues_plot, [pvalue0], label="p-dei-dati all'incertezza\nottima: $(round(pvalue0, digits=2))", c=:red, alpha=0.4)  # P-value ottimo
    
    scatter!(pvalues_plot, [sigma0], [pvalue0], label="", c=:red)  # Punto su p-value ottimo
    scatter!(pvalues_plot, [sigma1], [pvalue1], label="", c=:orange)  # Punto su p-value a -σ

    # Metto tutto assieme
    p = plot(chisq_mins_plot, pvalues_plot, link=:x, layout=(2,1), xlabel=["" "s_I [u.a.]"], ylabel=["χ²_min" "p-dei-dati"])

    return p
end