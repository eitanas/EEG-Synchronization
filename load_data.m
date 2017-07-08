function [data, t] = load_data(filename)

data = importdata(filename);
data = data.data;
data = data(:, 2:31);
t = data(:,1);

end