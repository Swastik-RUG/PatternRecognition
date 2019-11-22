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
end