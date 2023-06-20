%clear all

function [ellNS, ellNS_star, ellANSSMC, ellNSSMC, ell_Anneal, avg_evals] = Run_fn(N,R,runs,exact)
options.N = N; % number of particles
options.R = R; % repeats for MCMC steps
options.sig = 0.1; % for MCMC steps
options.d = 10; % dimension

options.c = 0*ones(1,options.d);

options.alpha = 0.975;
options.rho = exp(-1); % for NS-SMC
options.stopping_propZ = 0.999; % NS-SMC stopping rule
options.stopping_number = inf; % NS-SMC stopping rule
options.stopping_ESS = inf; % NS-SMC stopping rule
options.tol = 0.01; % for NS tuning of levels

vol = pi^(options.d/2)/factorial(options.d/2); % normalising constant of the prior
seed = 12345;
rng(seed);

options.R = R;
avg_evals = zeros(5,1)
%Nested Sampling / Improved Nested Sampling
ellNS = zeros(runs,1); ellNS_star = zeros(runs,1);
evals = 0;
fprintf('\nNS Runs: \n')
for i = 1:runs
    fprintf('%.0f ', i)
    if exact
        [theta, log_weights, log_evidence, count_loglike, log_adj] = NS_exact(options);
    else
        [theta, log_weights, log_evidence, count_loglike, log_adj] = NS_MCMC(options);
    end
    
    ellNS(i) = exp(log_evidence)*vol;
    ellNS_star(i) = exp(log_adj)*vol;
    evals = evals + count_loglike;
end


fprintf('\nNS: %.3f, std: %.2e, avg. evals: %.0f', mean(ellNS), std(ellNS)/sqrt(runs), evals/runs)
fprintf('\nINS: %.3f, std: %.2e, avg. evals: %.0f\n', mean(ellNS_star), std(ellNS_star)/sqrt(runs), evals/runs)

avg_evals(1) = evals/runs;
avg_evals(2) = evals/runs;

rng(seed)
evals = 0;
fprintf('\nNS-SMC Adaptive Runs: \n')
ellANSSMC = zeros(runs,1);
for i = 1:runs
    fprintf('%.0f ', i)
    if exact
        [theta, log_weights, log_evidence, count_loglike, levels, distances] = NSSMC_exact_adaptive(options);
    else
        [theta, log_weights, log_evidence, count_loglike, levels] = NSSMC_MCMC_adaptive(options);
    end
    ellANSSMC(i) = exp(log_evidence)*vol;
    evals = evals + count_loglike;
end

fprintf('\n\nNS-SMC Adaptive: %.3f, std: %.2e, avg. evals: %.0f \n', mean(ellANSSMC), std(ellANSSMC)/sqrt(runs), evals/runs)
avg_evals(3) = evals/runs;

levels
%NS-SMC: fixed run
fprintf('\n\nNS-SMC Fixed Runs: \n')
options.levels = levels;

ellNSSMC = zeros(runs,1);
evals =0;
for i = 1:runs
    fprintf('%.0f ', i)
    if exact
        options.distances = distances;
        [theta, log_weights, log_evidence, count_loglike, error_flag] = NSSMC_exact_fixed(options);
    else
        [theta, log_weights, log_evidence, count_loglike, error_flag] = NSSMC_MCMC_fixed(options);
    end
    ellNSSMC(i) =exp(log_evidence)*vol;
    evals = evals + count_loglike;
end

fprintf('\n\nNS-SMC Fixed: %.3f, std: %.2e, avg. evals: %.0f \n', mean(ellNSSMC), std(ellNSSMC)/sqrt(runs),  evals/runs)

avg_evals(4) = evals/runs;

ell_Anneal = zeros(runs,1);
if exact==0
% TA-SMC: adaptive run with MCMC sampler
options.R = 20;
evals = 0;
%fprintf('\nTA-SMC Runs: \n')
for i = 1:runs
    fprintf('%.0f ', i)
    [theta, loglike, log_evidence, count_loglike, gammavar] = anneal_MCMC_adaptive(options);
    ell_Anneal(i) = exp(log_evidence)*vol;
    ell_Anneal(i);
    evals = evals + count_loglike;
end
fprintf('\nTA-SMC: %.3f, std: %.2e, avg. evals: %.0f\n', mean(ell_Anneal), std(ell_Anneal)/sqrt(runs), evals/runs)

avg_evals(5) = evals/runs;
end



end
