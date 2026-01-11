# Riscrivere la documentazione

"""
Plotta punti sperimentali, curva teorica di best fit e redisui di un fit fatto con LsqFit.

# Argomenti:
- `model`: Il modello usato per fittare.
- `angle`: Vettore degli angoli.
- `x_angle_rad`: Vettore degli angoli (versione continua, in radianti).
- `intden_exp`: Vettore delle intensità misurate.
- `x_intden_th`: Vettore delle intensità calcolate a partire dal modello (versione continua).
- `resid`: Vettore dei residui.
- `sigma`: L'incertezza che è stata usata per fare il fit.

# Ritorna:
- Il plot.
"""

function plot_fit_ols(m, x, y_exp, sigma, params, resid; deg_to_rad=false)
    
    x_axis = first(x) - 5 : 0.1 : last(x) + 5  # Rivedere

    y_axis = deg_to_rad ? m(deg2rad.(x_axis), params) : m(x_axis, params)

    # Plotto curva di best fit e punti sperimentali
    exp_th_plot = plot()
    scatter!(exp_th_plot, x, y_exp, label="")  # I punti sperimentali
    plot!(exp_th_plot, x_axis, y_axis, label="Malus")  # La curva

    # Plotto i residui
    resid_plot = plot()

    scatter!(resid_plot, x, resid, label="")  # I residui

    colors = [:green, :yellow, :orange]
    αs = [0.25, 0.25, 0.15]

    for (i, (c, α)) in reverse(collect(enumerate(zip(colors, αs))))
        lower = 0 - i * sigma
        upper = 0 + i * sigma

        label_text = "$(i)σ ≈ ±$(@sprintf("%0.1e", i*sigma))"

        hline!(resid_plot, [lower], fillrange=upper, fillalpha=α, fillcolor=c, linealpha=0, label=label_text)  # Le bande
    end

    hline!(resid_plot, [0], c=:red, label="")  # Lo zero

    # Metto tutto assieme
    exp_th_resid_plot = plot(
        exp_th_plot,
        resid_plot,
        link=:x,
        layout=(2,1),
        xlabel=["" "Angolo [°]"],
        ylabel=["Intensità [u.a.]" "Residui [u.a.]"],
        xticks=[(x, []) (x, x)],
        legend=[(0.12, 0.9) (0.12,0.40)]
        )

    return exp_th_resid_plot
end