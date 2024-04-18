% Function to compute the distance between model output probabilities of emigration and real data emigration

function distance = prob_distance(x, pr,edu)
       model =my_model_migration; 
       model.dus=x(1);
       model.lambda=x(2); 
       if edu == 0
           model.inc0 = 0.75;
       else
           model.inc0 = 0.60;
       end
       model.minc0 = model_high.inc0*1.4;

       model.solve_dcegm;
       model.sim;

       mean_prob = mean(model.sims.prob_stay);
       high1 =1- mean(mean_prob_high(5:19));
       high2 =1- mean(mean_prob_high(20:44));
       high3 =1- mean(mean_prob_high(45:62));
       grouped = [high1,high2,high3];
       rhigh1 =1 -pr{1,9};
       rhigh2 = 1-pr{2,9};
       rhigh3 = 1-pr{3,9};
       grouped_real = [rhigh1,rhigh2,rhigh3];
       
       distance = mean((grouped_rhigh_real-grouped_high).^2);

end 
