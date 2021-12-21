module UIT_Module

using Plots

export findlocalmaxima
export B_to_M

function findlocalmaxima(signal)
    inds = Int[]
    if length(signal)>1
        if signal[1]>signal[2]
            push!(inds,1)
        end
        for i=2:length(signal)-1
            if signal[i-1]<signal[i]>signal[i+1]
                push!(inds,i)
            end
        end
        if signal[end]>signal[end-1]
            push!(inds,length(signal))
        end
    end
    inds
end

function findlocalmaxima(signal, cutoff)
    inds = Int[]
    if length(signal)>1
        if signal[1]>signal[2] && signal[1]>cutoff
            
            push!(inds,1)
        end
        for i=2:length(signal)-1
            if signal[i-1]<signal[i]>signal[i+1] && signal[i]>cutoff
                push!(inds,i)
            end
        end
        if signal[end]>signal[end-1] && signal[i]>cutoff
            push!(inds,length(signal))
        end
    end
    inds
end

function B_to_M(B)
    return 0.6317695451527946 - 0.0003191680112494011*B + 1.7132190264932122e-6*B^2
end


"""
    my_theme()
Description of ```my_theme```
------------------------------
sets custom theme for Plots with the following attributes:

    + :wong2,
    + legend =:false,
    + left_margin = 6Plots.mm,
    + right_margin = 12Plots.mm,
    + top_margin  = 4Plots.mm,
    + bottom_margin  = 6Plots.mm,
    + framestyle = :box,
    + grid = :off,
    + size = (1200,600),
    + dpi = 400,
    + color = "blue"
"""
function my_theme()
    return Plots.theme(:wong2,
                        legend =:false,
                        left_margin = 6Plots.mm,
                        right_margin = 12Plots.mm,
                        top_margin  = 4Plots.mm,
                        bottom_margin  = 6Plots.mm,
                        framestyle = :box,
                        grid = :off,
                        size = (800,400),
                        dpi = 400,
                        color = "blue"
                        )
end

"""
    get_accelerated_E
Description of ```get_accelerated_E```
------------------------------
Calculates E after accelerator with the following methods:

    + molecular get_accelerated_E(q, E0, TV, M1, Mtot) = M1/Mtot*(E0+TV) +q*TV
    + atomic get_accelerated_E(q, E0, TV) = (E0+TV) +q*TV
    
"""
function get_accelerated_E(q, E0, TV, M1, Mtot)
    return M1/Mtot*(E0+TV) +q*TV
end

function get_accelerated_E(q, E0, TV)
    return (E0+TV) +q*TV
end


"""
    get_B()
Description of ```get_B```
------------------------------
Calculates B in [T] with the following methods:

    + basic: get_B(q, r, E, M) = 1/(q*r)*sqrt(E*M/48.25)
    + if same q but diff M1,M2: get_B(B1, M1, M2) = B1/(sqrt(M1/M2))
    + if same M but diff q: get_B(B1, E1, E2, q1, q2) = B1*sqrt(E2/E1)*q1/q2
    
"""
function get_B(q, r, E, M)
    return 1/(q*r)*sqrt(E*M/48.25)
end

function get_B(B1, M1, M2)
    return B1/(sqrt(M1/M2))
end

function get_B(B1, E1, E2, q1, q2)
    return B1*sqrt(E2/E1)*q1/q2
end

end