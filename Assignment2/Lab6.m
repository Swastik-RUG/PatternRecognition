% DISCARDED

terms = {'Anti-aging', 'Customers', 'Fun', 'Groningen', 'Lecture', 'Money', 'Vacation', 'Viagra', 'Watches'};
spam = {0.00062, 0.005, 0.00015, 0.00001, 0.000015 0.002, 0.00025, 0.001, 0.0003};
notSpam = {0.000000035, 0.0001, 0.0007, 0.001, 0.0008, 0.0005, 0.00014, 0.0000003, 0.000004};
spamDict = containers.Map(terms, spam);
notSpamDict = containers.Map(terms, notSpam);
fprintf("--------------TERM: We offer our dear customers a wide selection of classy watches-----------------------\n");
q1spam = getSpam('Anti-aging') * spamDict('Customers') * getSpam('Fun') * getSpam('Groningen') * getSpam('Lecture') * getSpam('Money') * getSpam('Vacation') * getSpam('Viagra')*spamDict('Watches');
q1Notspam = getNotSpam('Anti-aging')*getNotSpam('Customers')*getNotSpam('Fun')*getNotSpam('Groningen')*getNotSpam('Lecture')*getNotSpam('Money')*getNotSpam('Vacation')*getNotSpam('Viagra')*notSpamDict('Watches');

probS = 0.9;
probNs = 0.1;

res_notspam = q1Notspam*probNs / ((q1Notspam*probNs)+(q1spam*probS));
res_notspam
fprintf("%f \n", res_notspam);

res_spam = q1spam*probS / ((q1Notspam*probNs)+(q1spam*probS));
res_spam
fprintf("%f \n", res_spam);

fprintf("-----------------------------------------------------------------------------------------------------------------------------------------------------\n")
fprintf("--------------TERM: Did you have fun on vacation? I sure did! -----------------------\n")

q2spam = getSpam('Anti-aging') * getSpam('Customers') * spamDict('Fun') * getSpam('Groningen') * getSpam('Lecture') * getSpam('Money') * spamDict('Vacation') * getSpam('Viagra')*getSpam('Watches');
q2Notspam = getNotSpam('Anti-aging')*getNotSpam('Customers')*notSpamDict('Fun')*getNotSpam('Groningen')*getNotSpam('Lecture')*getNotSpam('Money')*notSpamDict('Vacation')*getNotSpam('Viagra')*getNotSpam('Watches');
res2_notspam = q2Notspam*probNs / ((q2Notspam*probNs)+(q2spam*probS));
res2_notspam
fprintf("%f \n", res2_notspam);

res2_spam = q2spam*probS / ((q2Notspam*probNs)+(q2spam*probS));
res2_spam
fprintf("%f \n", res2_spam);
fprintf("-----------------------------------------------------------------------------------------------------------------------------------------------------\n")

function spamP = getSpam(term)
terms = {'Anti-aging', 'Customers', 'Fun', 'Groningen', 'Lecture', 'Money', 'Vacation', 'Viagra', 'Watches'};
spam = {0.00062, 0.005, 0.00015, 0.00001, 0.000015 0.002, 0.00025, 0.001, 0.0003};
spamDict = containers.Map(terms, spam);
    spamP = 1-spamDict(term);
end

function notspamP = getNotSpam(term)
terms = {'Anti-aging', 'Customers', 'Fun', 'Groningen', 'Lecture', 'Money', 'Vacation', 'Viagra', 'Watches'};
notSpam = {0.000000035, 0.0001, 0.0007, 0.001, 0.0008, 0.0005, 0.00014, 0.0000003, 0.000004};
notSpamDict = containers.Map(terms, notSpam);
    notspamP = 1-notSpamDict(term);
end
