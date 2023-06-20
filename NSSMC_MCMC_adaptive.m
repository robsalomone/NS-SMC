function [theta, log_weights, log_evidence, count_loglike, levels] = NSSMC_MCMC_adaptive(options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options        -  options.N: Size of population of particles
%                -  options.rho: For choosing schedule
%                -  options.R: fixed number of MCMC repeats
%                -  options.sig: fixed parameter for sampler
%                -  options.d: dimension

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% theta          -  Samples from the posterior (weights below)
%
% log_weights    -  Log weights for the samples
%
% log_evidence 	 -  The log evidence estimate (not necessarily unbiased when
%                   adapting the temperatures and proposals adaptively
%                   online)
%
% count_loglike  -  The total log likelihood computations
%
% levels         -  The thresholding levels

N = options.N;
rho = options.rho;
R = options.R;
d = options.d;
sig = options.sig;
stopping_number = options.stopping_number;
stopping_propZ = options.stopping_propZ;
stopping_ESS = options.stopping_ESS;

theta_curr = simprior_fn(N,options);
t = 1;

%initialise
log_evidence = -inf;

terminate = false;
theta = [];
log_weights = [];
levels = -inf;
prod_c = 1;
m = 0;

prop_Z = 0;
ESS_early = 0;

c = options.c;
L_max=loglike_fn(c,options);

loglike_curr = zeros(N,1);
for i=1:N
    loglike_curr(i) = loglike_fn(theta_curr(i,:),options);
end

count_loglike = ones(N,1);


% ------------
U = rand(N,1); %% 
alpha = rho; %% 
% ------------

desired_p = ceil(N * alpha)/N; %for debugging

while ~terminate
    t = t+1;
   
%     ostats = sort(loglike_curr);
%     levels(t) = ostats(floor((1-rho)*N));
%     el_ind = (loglike_curr>levels(t)); %indices of elite set

    [levels(t), el_ind, ~, ~,~] = get_ids(loglike_curr,U,alpha);
    
    %---- decide whether or not to terminate -----
    if exp(levels(t)-L_max) > 0.75
        terminate = true;
        levels(t) = Inf; % forces final strata
    end
    %------------------------------------------
 
    num_elites = sum(el_ind);
    c = num_elites/N;
    
    if c == 1
        error('All Elites: Too many levels / Particles not moving')
    end
    
    if c==0 && levels(t) ~= inf
        levels(t)
        error('No elites:  Particles not moving')
    end
    
     
    %--- weighted (unnormalized) samples---
    logw = loglike_curr(~el_ind) + log(prod_c);
    term = logsumexp(logw) - log(N);
    log_evidence = logsumexp([log_evidence term]);
    %--------------------------------------
    
    %------ Storing the new samples ------
    new_inds = (m+1):(m+sum(~el_ind));
    theta(new_inds,:) = theta_curr(~el_ind,:);
    log_weights(new_inds,1) = logw;
    m = max(new_inds);
    % ------------------------------------
    
    assert(desired_p == c)
    prod_c = prod_c*c;
    
    
    % Resample and Move
    % Note --- all the weights are equal so we just sample uniformly
    if levels(t) ~= Inf
        % ------ % 
        resamp_weights = el_ind/num_elites;
        % ------ %
        inds = resampleMultinomial(resamp_weights);
        
        theta_curr = theta_curr(inds,:);
        loglike_curr = loglike_curr(inds);
        
        for i=1:N
            for k=1:R
                if rand < 0.5
                    sig = options.sig;
                else
                    sig = options.sig/4;
                end
                
                theta_prop = theta_curr(i,:);
                loc = ceil(rand*d);
                theta_prop(loc) = theta_prop(loc) + sig*randn;
                
                if norm(theta_prop)<1
                    loglike_prop = loglike_fn(theta_prop,options);
                    count_loglike(i) = count_loglike(i) + 1;
                    if loglike_prop > levels(t)
                        theta_curr(i,:) = theta_prop;
                        loglike_curr(i,:) = loglike_prop;
                    end
                end
            end
        end
    end
    
end

log_weights = log_weights - logsumexp(log_weights);

count_loglike = sum(count_loglike);

end
