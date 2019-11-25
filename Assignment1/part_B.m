dinfo = dir('person*.mat');
iterations = 10000;
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
        data = cell2mat(seedData(randomPersonIndx));
        personData = data.iriscode;
        data = personData(randperm(length(personData(:,1)),2),:);
        hd = pdist2(data(1,:), data(2,:), 'hamming');
        numberOfDifferences = size(data, 2)*hd;
        fprintf("Computing the Hamming distance for person%02d.mat \n",randomPersonIndx)
        fprintf("Vectors selected \n")
        %data
        fprintf("Hammind distance = %f \n", hd);
        fprintf("Number of missmatches in the bit position = %d \n", numberOfDifferences)
        s_set = [s_set; [fileNames(randomPersonIndx), data, hd, numberOfDifferences]];       
    end

% Create the D set
    d_set = {}
    for itr = 1:iterations
        randomPersons = randperm(length(seedData), 2);
        tmpData_i = cell2mat(seedData(randomPersons(1)));
        tmpData_j = cell2mat(seedData(randomPersons(2)));
        person_i = tmpData_i.iriscode(randperm(length(personData(:,1)),1),:);
        person_j = tmpData_j.iriscode(randperm(length(personData(:,1)),1),:);
        
        hd =  pdist2(person_i,person_j, 'hamming');
        numberOfDiff = size(person_i, 2)*hd;
        
        fprintf("Computing the Hamming distance between person%02d.mat and person%02d.mat \n",randomPersons(1), randomPersons(2))
        fprintf("Vectors selected \n")
        fprintf("person%20d \n", randomPersons(1))
        %person_i
        fprintf("person%20d \n", randomPersons(2))
        %person_j
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
    fprintf("\n---------------------------------BINS USED TO PLOT THE HISTOGRAM-----------------------------------\n")
    fprintf("BINS = %d\n", bins);
    fprintf("---------------------------------------------------------------------------------------------------\n")

    
    fprintf("\n--------------------------------------SUMMARY OF SET S---------------------------------------------\n")
    fprintf("The Mean of Set S = %f \n", mean(hd_s));
    fprintf("The Variance of Set S = %f \n", var(hd_s));
    fprintf("---------------------------------------------------------------------------------------------------\n")
    fprintf("\n--------------------------------------SUMMARY OF SET D---------------------------------------------\n")
    fprintf("The Mean of Set D = %f \n", mean(hd_d));
    fprintf("The Variance of Set D = %f \n", var(hd_d));
    fprintf("\n---------------------------------------------------------------------------------------------------\n")
    
    
    figure('Name','Histogram of Set S and D')
    clf(1);
    a = histogram(hd_s, bins);
    hold on
    b = histogram(hd_d, bins);
    legend([a, b], {'Set S', 'Set D'});
    xlabel("Hamming Distance")
    ylabel("Occurance of HD in the Set")
    grid on
    
    figure('Name','Histogram of Set S and D with Gaussian distribution Curve')  
    clf(2);
    [hts,ctrs] = hist(hd_s);
    a = histogram(hd_s, bins);
    area = sum(hts) * (ctrs(2)-ctrs(1));
    xx = linspace(min(hd_s),max(hd_s),bins);
    hold on; 
    plot(xx, smooth(area*normpdf(xx, mean(hd_s),sqrt(var(hd_s)))),'r-')
    hold on;
    [hts2,ctrs2] = hist(hd_d);
    b = histogram(hd_d, bins);
    area2 = sum(hts2) * (ctrs2(2)-ctrs2(1));
    xx2 = linspace(min(hd_d),max(hd_d),bins);
    hold on; 
    plot(xx2, smooth(area*normpdf(xx2, mean(hd_d),sqrt(var(hd_d)))),'r-')
    legend([a, b], {'Set S', 'Set D'});
    xlabel("Hamming Distance")
    ylabel("Occurance of HD in the Set")
    hold off

    normcdf_D = normcdf(hd_d, mean(hd_d), std(hd_d));
    far={};
    fprintf("\n--------------------------------------FAR-----------------------------------------------\n")
    fprintf("Find the Hamming Distance threshold when FAR = 0.0005\n");
    for i=1:length(hd_d)
        if fix(normcdf_D(i)*1e4)/1e4 == fix(0.0005*1e4)/1e4
            far = [far; [normcdf_D(i), hd_d(i)]];
            fprintf(" => False Acceptance Rate = %f for HD = %f\n", normcdf_D(i), hd_d(i))
        end
    end
    fprintf("------------------------------------------------------------------------------------\n")

% calculted False regection rate
norm_s=normcdf(hd_s, mean(hd_s), std(hd_s));
frr=[];
count2=0;

if length(hd_s) == length(norm_s);
    for i=1;length(hd_s);
        if abs(hd_s(i)-0.2) > 1e4*eps(min(abs(hd_s(i)),abs(0.20)))
            frr(i-count2)=hd_s(i);
        elseif abs(hd_s(i)-0.2) <= 1e4*eps(min(abs(hd_s(i)),abs(0.20)))
            count2=count2+1;
        end
fprintf("\n----------------------------------FRR-------------------------------------------------\n")
fprintf("The False Rejection Rate = %f\n", frr);
fprintf("--------------------------------------------------------------------------------------\n") 
    end            
end


testPersonData = load('testperson.mat');
testPersonData = testPersonData.iriscode;
z = find(testPersonData == 2);
c = 1;
reshapedTestPerson = [];
for i = 1:length(testPersonData)
    if ismember(i, z) == 0
        reshapedTestPerson(c) = testPersonData(i);
        c = c +1;
    end
end

res = {};
for k = 1 : length(dinfo)
    tmpData = cell2mat(seedData(k));
    refPerson = tmpData.iriscode;
    %z = k
    hd = pdist2(testPersonData, refPerson, 'hamming');
    for j = 1: length(hd)
        if abs(hd(j)-0.20) <= 1e4*eps(min(abs(hd(j)),abs(0.20)))
            fprintf("Sameperson %d", k)
        end
        res = [res; fileNames(k), hd(j)];
    end
end
sorted_res = sortrows(res, 2);
fileName = string(sorted_res(1,1));
hammingDist = string(sorted_res(1,2));

fprintf("----------------------------TEST PERSON UNMASKED-----------------------------------------------\n")
fprintf("TestPerson with bit values 2 retained:\n")
fprintf("The testperson closely matches with the %s with a Hamming Distance = %s\n", fileName, hammingDist);
fprintf("-----------------------------------------------------------------------------------------------\n")

rres = {};
for k = 1 : length(dinfo)
    tmpData = cell2mat(seedData(k));
    refPerson = tmpData.iriscode;
    %z = k
    for i = 1:size(refPerson,1)
        c = 1;
        data = refPerson(i,:);
        rdata = [];
          for q = 1: length(data)
            if ismember(q, z) == 0
                rdata(c) = data(q);
                c = c + 1;
            end
          end
         hd = pdist2(reshapedTestPerson, rdata, 'hamming');
        if abs(hd-0.20) <= 1e4*eps(min(abs(hd),abs(0.20)))
            fprintf("Sameperson %d", k)
        end
       rres = [rres; fileNames(k), hd];
    end
end
sorted_res = sortrows(rres, 2);
fileName = string(sorted_res(1,1));
hammingDist = string(sorted_res(1,2));
fprintf("\n-------------------------------TEST PERSON MASKED-------------------------------------------\n")
fprintf("TestPerson with bit values 2 Masked:\n")
fprintf("The testperson closely matches with the %s with a Hamming Distance = %s\n", fileName, hammingDist);
fprintf("--------------------------------------------------------------------------------------------\n")

if size(far,1) == 0
    fprintf("!!!!!!Rare Scenario Encountered on displaying FAR around 0.0005, Restart the Simulation!!!!!!");
    fprintf("This is caused due to the randomness while picking the data")
end
    