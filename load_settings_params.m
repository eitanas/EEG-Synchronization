function  params = load_settings_params (~)

params.delta1_st_fr = 0.5;
params.delta1_end_fr = 1.99;

params.delta2_st_fr = 2;
params.delta2_end_fr = 3.99;

params.delta_st_fr = 2;
params.delta_end_fr = 3.99;

params.theta_st_fr = 4;
params.theta_end_fr = 6.99;

params.alpha_st_fr = 7;
params.alpha_end_fr = 11.49;

params.sigma_st_fr = 11.5;
params.sigma_end_fr = 15.99;

params.betha_st_fr = 16;
params.betha_end_fr = 22;

params.gamma_st_fr = 22;
params.gamma_end_fr = 50;

params.BW = cell(1,6);
params.BW{1} = 'delta';
params.BW{2} = 'theta';
params.BW{3} = 'alpha';
params.BW{4} = 'sigma';
params.BW{5} = 'beta';
params.BW{6} = 'gamma';

params.sampling_fr = 256;

end