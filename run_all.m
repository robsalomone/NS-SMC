%%
clear all 
p = fileparts(which('Run.m')); % getting the location of the 'Run.m' file
location = strcat(p(1:(strfind(p, '\PhaseTransition'))), 'code'); % getting the location of the 'code' folder - Windows
% location = strcat(p(1:(strfind(p, '/PhaseTransition'))), 'code'); % getting the location of the 'code' folder
addpath(genpath(location)); % adding the contents of the 'code' folder to the working directory
R = 10; % number of MCMC repeats

mult = 1;

% ----EXACT SAMPLER-----------------------------------------------
exact_sample = 1; % use exact sampler (0 for exact, 1 for MCMC)

% ------------- 
rng(1)
N = 1e2; % number of particles
runs = 1e4 * mult;
[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_100N_10000runsEXACT.mat') 

% ------------- 
rng(1)
N = 1e3; % number of particles
runs = 1e3 * mult;

[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_1000N_1000runsEXACT.mat') 

% ------------- 
rng(1)
N = 1e4; % number of particles
runs = 1e2 * mult;

[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_10000N_100runsEXACT.mat') 

% ----MCMC ----------------------------------------------------
exact_sample = 0; % use exact sampler (0 for exact, 1 for MCMC)

% ------------- 
rng(1)
N = 1e2; % number of particles
runs = 1e4 * mult;
[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_100N_10000runs.mat') 

% ------------- 
rng(1)
N = 1e3; % number of particles
runs = 1e3 * mult;

[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_1000N_1000runs.mat') 

% ------------- 
rng(1)
N = 1e4; % number of particles
runs = 1e2 * mult;

[ellNS, ellNSstar, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact_sample)
save('d10_10000N_100runs.mat') 
