function distance = prob_distance(x, pr,edu)
       model_high=my_model_migration; 
       model_high.dus=x(1);
       model_high.lambda=x(2); 
       if edu == 0
           model_high.inc0 = 0.75;
       else
           model_high.inc0 = 0.60;
       end
       model_high.minc0 = model_high.inc0*1.4;

       model_high.solve_dcegm;
       model_high.sim;

       mean_prob_high = mean(model_high.sims.prob_stay);
       high1 =1- mean(mean_prob_high(5:19));
       high2 =1- mean(mean_prob_high(20:44));
       high3 =1- mean(mean_prob_high(45:62));
       grouped_high = [high1,high2,high3];
       rhigh1 =1 -pr{1,9};
       rhigh2 = 1-pr{2,9};
       rhigh3 = 1-pr{3,9};
       grouped_rhigh_real = [rhigh1,rhigh2,rhigh3];

       %model_low=my_model_migration; 
       %model_low.dus=x(1);
       %model_low.lambda=x(2); 
       %model_low.inc0 = 0.50;
       %model_low.minc0 = model_low.inc0*1.3;
%
       %model_low.solve_dcegm;
       %model_low.sim;
%
       %mean_prob_low = mean(model_low.sims.prob_stay);
       %low1 =1- mean(mean_prob_low(5:19));
       %low2 =1- mean(mean_prob_low(20:44));
       %low3 =1- mean(mean_prob_low(45:47));
       %grouped_low = [low1,low2,low3];
       %rhigh1 =1 -pr{1,9};
       %rhigh2 = 1-pr{2,9};
       %rhigh3 = 1-pr{3,9};
       %grouped_rlow_real = [rhigh1,rhigh2,rhigh3];
%
       %distance1 = abs(mean(grouped_rhigh_real-grouped_high));
       %distance2 = abs(mean(grouped_rlow_real-grouped_low));
       %distance = distance1 + distance2;

       %distance1 = abs(grouped_rhigh_real(1)-grouped_high(1));
       %distance2 = abs(grouped_rlow_real(1)-grouped_low(1));
       %distance = distance1 + distance2;

       distance = mean((grouped_rhigh_real-grouped_high).^2);

end 
