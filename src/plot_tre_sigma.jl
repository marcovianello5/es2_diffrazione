"""
Plot con le tre bande di deviazione standard evidenziate con colore diverso.

# Argomenti:
- `y`: Il campione.
- `xlab=""`: La label dell'asse x.
- `ylab=""`: La label dell'asse y.

# Ritorna:
- ndovina
"""
function plot_tre_sigma(y; xlab="", ylab="")
    # Determino la deviazione standard del campione
    mu = mean(y)
    sigma = std(y)
    
    p = plot()
    
    # Plotto le bande
    colors = [:green, :yellow, :orange, :blue]
    αs = [0.25, 0.25, 0.15, 0.00]
    
    for (i, (c, α)) in zip(colors, αs) |> enumerate |> collect |> reverse
        lower = mu - i * sigma
        upper = mu + i * sigma
        
        label_text = i<4 ? "$(i)σ ≈ ±$(@sprintf("%0.1e", i*sigma))" : ""
        
        hline!(p, [lower], fillrange=upper, fillalpha=α, fillcolor=c, linealpha=0, label=label_text)
    end
    
    hline!(p, [mu], label="media", alpha=1)  # Linea sul valore medio

    scatter!(p, y, yerr=sigma, label=("punti sperimentali"), xticks=1:length(y))  # Plotto gli y
    
    # Setto gli assi
    xlabel!(p, xlab)
    ylabel!(p, ylab)

    return p
end