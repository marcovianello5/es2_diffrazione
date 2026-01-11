function plot_fit_ord(m!, x, y_exp, sigmay, params, resid; deg_to_rad=false)
    
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
        lower = 0 - i * sigmay
        upper = 0 + i * sigmay

        label_text = "$(i)σ ≈ ±$(@sprintf("%0.1e", i*sigmay))"

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
        legend=[(0.12, 0.9) (0.12,0.40)]
        )

    return exp_th_resid_plot
end