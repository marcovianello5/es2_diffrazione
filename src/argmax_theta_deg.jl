function argmax_theta_deg(model, params, theta0)
    # Trovo il massimo
    f = x -> -model(x[1], params)[1]  # Così funziona ma nn so perché :(

    res = optimize(f, theta0)
    theta_opt_rad = Optim.minimizer(res)  # In radianti!

    return rad2deg.(theta_opt_rad)[1]
end