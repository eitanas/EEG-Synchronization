function s = get_signal_interval(data, wave, num, params, start_time, end_time)
%this function gets data, electrode number, brain wave name and time
%interval and returns the requested signal

electrode_num = num;

switch wave
    case char('delta1')
        st_fr = params.delta1_st_fr;
        end_fr = params.delta1_end_fr;
    case char('delta2')
        st_fr = params.delta2_st_fr;
        end_fr = params.delta2_end_fr;
    case char('delta')
        st_fr = params.delta_st_fr;
        end_fr = params.delta_end_fr;
    case char('theta')
        st_fr = params.theta_st_fr;
        end_fr = params.theta_end_fr;
    case char('alpha')
        st_fr = params.alpha_st_fr;
        end_fr = params.alpha_end_fr;
    case char('sigma')
        st_fr = params.sigma_st_fr;
        end_fr = params.sigma_end_fr;
    case char('beta')
        st_fr = params.betha_st_fr;
        end_fr = params.betha_end_fr;
    case char('gamma')
        st_fr = params.gamma_st_fr;
        end_fr = params.gamma_end_fr;
end

signal = ExtractSignalwave(st_fr, end_fr, data(:,electrode_num), params.sampling_fr);

start_idx = floor(start_time * params.sampling_fr);
end_idx = floor(end_time * params.sampling_fr);

s = signal(start_idx:end_idx);

end