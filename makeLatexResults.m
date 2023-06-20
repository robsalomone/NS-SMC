
mult = 1;

load('d10_100N_10000runsEXACT.mat') 
runs=10000*mult;

c1_1 = sprintf('EXACT & NS & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c1_2 =sprintf(' & NS* & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c1_3 = sprintf(' & ANS-SMC & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c1_4 = sprintf(' & NS-SMC & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));


load('d10_1000N_1000runsEXACT.mat') 
runs=1000*mult;

c2_1 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c2_2 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c2_3 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c2_4 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));


load('d10_10000N_100runsEXACT.mat') 
runs=100*mult;

c3_1 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c3_2 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c3_3 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c3_4 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));

disp(strcat(c1_1, c2_1, c3_1))
disp(strcat(c1_2, c2_2, c3_2))
disp(strcat(c1_3, c2_3, c3_3))
disp(strcat(c1_4, c2_4, c3_4))

disp(' ')
load('d10_100N_10000runs.mat') 
runs=10000*mult;

c1_1 = sprintf('MCMC & NS & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c1_2 = sprintf(' & NS* & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c1_3 = sprintf(' & ANS-SMC & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c1_4 = sprintf(' & NS-SMC & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));
c1_5 = sprintf(' & SMC & %.2f (%.2f) & \\num{%.1e}', mean(ell_Anneal),std(ell_Anneal)/sqrt(runs)*100, avg_evals(5));


 
load('d10_1000N_1000runs.mat') 
runs=1000*mult;

c2_1 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c2_2 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c2_3 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c2_4 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));
c2_5 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ell_Anneal),std(ell_Anneal)/sqrt(runs)*100, avg_evals(5));


load('d10_10000N_100runs.mat') 
runs=100*mult;
c3_1 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNS),std(ellNS)/sqrt(runs)*100, avg_evals(1));
c3_2 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSstar),std(ellNSstar)/sqrt(runs)*100, avg_evals(2));
c3_3 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellANSSMC),std(ellANSSMC)/sqrt(runs)*100, avg_evals(3));
c3_4 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ellNSSMC),std(ellNSSMC)/sqrt(runs)*100, avg_evals(4));
c3_5 = sprintf(' & %.2f (%.2f) & \\num{%.1e}', mean(ell_Anneal),std(ell_Anneal)/sqrt(runs)*100, avg_evals(5));

disp(strcat(c1_1, c2_1, c3_1))
disp(strcat(c1_2, c2_2, c3_2))
disp(strcat(c1_3, c2_3, c3_3))
disp(strcat(c1_4, c2_4, c3_4))
disp(strcat(c1_5, c2_5, c3_5))
