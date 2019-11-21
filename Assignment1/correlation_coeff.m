function correlatipn = correlation_coeff()

inputdata = load( 'lab1_1.mat')
whos -file lab1_1.mat
vals = [inputdata(1:10)]
#f1 = vertcat(inputdata.height)
class(inputdata)
cor = struct2cell(inputdata)
end