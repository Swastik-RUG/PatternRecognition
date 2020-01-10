data=load('lab3_1.mat');
data=data.outcomes;
total_trials=length(data);
hit_pos=0;
hit_neg=0;
false_pos=0;
false_neg=0;

hitpoints=zeros(1,numel(total_trials));
falsepoints=zeros(1,numel(total_trials));

for i=1:length(data)
   tmp=data(i,:);
   if tmp(1,1)==1 && tmp(1,2)==1
      hit_pos=hit_pos+1;
   elseif tmp(1,1)==0 && tmp(1,2)==1
      false_pos=false_pos+1;
   elseif tmp(1,1)==1 && tmp(1,2)==0
      hit_neg=hit_neg+1;
   elseif tmp(1,1)==0 && tmp(1,2)==0
       false_neg=false_neg+1;
   end
    
end

hit_rate=hit_pos/(hit_pos+false_neg);
false_rate=false_pos/(false_pos+hit_neg);


z_score_hit=norminv(hit_rate)
z_score_false=norminv(false_rate)

d_prime=z_score_hit-z_score_false

%plotroc(hitpoints,falsepoints)
