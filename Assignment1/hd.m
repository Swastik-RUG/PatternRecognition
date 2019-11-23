function hammingdistance = hd()
dinfo = dir('person*.mat');
iterations = 1000;
fileNames = {};
seedData = {};
for k = 1 : length(dinfo)
    thisfilename = dinfo(k).name;  %just the name
    thisdata = load(thisfilename); %load just this file
    fileNames = [fileNames,thisfilename];
    seedData = [seedData,thisdata];
end
% Create the S set
    s_set = {}
    for itr = 1:iterations
        randomPersonIndx = randi(length(fileNames));
        personData = cell2mat(seedData(randomPersonIndx)).iriscode;
        data = personData(randperm(length(personData(:,1)),2),:);
        hd = pdist(data, 'hamming');
        numberOfDifferences = size(data, 2)*hd
        fprintf("Computing the Hamming distance for person%02d.mat \n",randomPersonIndx)
        fprintf("Vectors selected \n")
        data
        fprintf("Hammind distance = %f \n", hd);
        fprintf("Number of missmatches in the bit position = %d \n", numberOfDifferences)
        s_set = [s_set; [fileNames(randomPersonIndx), data, hd, numberOfDifferences]];       
    end

% Create the D set
    d_set = {}
    for itr = 1:iterations
        randomPersons = randperm(length(seedData), 2);
        person_i = cell2mat(seedData(randomPersons(1))).iriscode(randperm(length(personData(:,1)),1),:);
        person_j = cell2mat(seedData(randomPersons(2))).iriscode(randperm(length(personData(:,1)),1),:);
        
        hd =  pdist([person_i;person_j], 'hamming');
        numberOfDiff = size(person_i, 2)*hd
        
        fprintf("Computing the Hamming distance between person%02d.mat and person%02d.mat \n",randomPersons(1), randomPersons(2))
        fprintf("Vectors selected \n")
        fprintf("person%20d \n", randomPersons(1))
        person_i
        fprintf("person%20d \n", randomPersons(2))
        person_j
        fprintf("Hammind distance = %f \n", hd);
        fprintf("Number of missmatches in the bit position = %d \n", numberOfDifferences)
        d_set = [d_set; [fileNames(randomPersons(1)), person_i, fileNames(randomPersons(2)),person_j, hd, numberOfDiff]];       
    end
    % Plot the Histograms of Set S and Set D.
    hd_s = cell2mat(s_set(:,3));
    hd_d = cell2mat(d_set(:,5));
    [~, binS] = histcounts(hd_s);
    [~, binD] = histcounts(hd_d);
    bins = floor(min(size(binS, 2), size(binD, 2))/2);
    fprintf("The Mean of Set S = %f \n", mean(hd_s));
    fprintf("The Variance of Set S = %f \n", var(hd_s));
    fprintf("The Mean of Set D = %f \n", mean(hd_d));
    fprintf("The Variance of Set D = %f \n", var(hd_d));
    figure(1)
    a = histogram(hd_s, bins);
    xlabel("Hamming Distance")
    ylabel("Occurance of HD in the Set")
    legend(a, {'Set S'});
    hold on
    b = histogram(hd_d, bins);
    legend(b, {'Set D'});
    grid on
    
   % hd_s_normal_dist = getNormalDist(mean(hd_s), var(hd_s));
   % hd_d_normal_dist = getNormalDist(mean(hd_d), var(hd_d));
   % npd = normpdf(hd_s_normal_dist, mean(hd_s), var(hd_s));

    figure(2)
    histogram(hd_s, bins);
    hold on
    histogram(hd_d, bins);
    grid on
    figure(3)
    % This is not correct, we need to generate the normal distribution
    % using the density function. https://public.tableau.com/en-us/s/blog/2013/11/fitting-normal-curve-histogram
    x = (-5 * std(hd_s):0.01:5 * std(hd_s)) + mean(hd_s);
    plot(hd_s, normpdf(hd_s, mean(hd_s), std(hd_s)));
    hold on
    y = (-5 * std(hd_d):0.01:5 * std(hd_d)) + mean(hd_d);
    plot(hd_d, normpdf(hd_d,mean(hd_d),std(hd_d)));
    grid on
    


    
    function normalDist = getNormalDist(x, mean, var)
        std = sqrt(var);
        normalDist = [mean-3*std, mean-2*std, mean-std, mean, mean+std, mean+2*std, mean+3*std];
    end
end