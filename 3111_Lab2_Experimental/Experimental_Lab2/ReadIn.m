%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alec Viets
% ASEN 3111
% Experimental Lab 2
% ReadIn function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function wing = ReadIn(type)

newFolder = 'FINAL_Master_Ex_Lab_02_Data';
oldFolder = cd;
cd(newFolder);

files = dir('*.csv');

count = 1;
for i = 1:length(files)
    data{i} = csvread(files(i).name,1);
    ID{i} = strsplit(files(i).name,'_');
    ID{i}{5} = ID{i}{5}(1:end-4);
end

odd = zeros(24000,28);
even = zeros(24000,28);
count_odd = 0;
count_even = 0;
check = true;

for i = 1:length(files)
    id = ID{i};
    
    [m,n] = size(data{i}); % find size of input matrix
    if m == 24000
        if strcmp(id{5},type)
            if strcmp(id{4},'Odd')
                dataodd = data{i};
                odd = odd + dataodd;
                count_odd = count_odd + 1;
            elseif strcmp(id{4},'Even')
                dataeven = data{i};
                even = even + dataeven;
                count_even = count_even + 1;
            end
        end
    elseif m == 16000
        if strcmp(id{5},type)
            if strcmp(id{4},'Odd')
                for j = 1:length(data)
                    if strcmp(ID{j}{5},type) && check
                        dataodd_append = data{j}(1:8000,:);
                        check = false;
                    end
                end
                dataodd_new = [dataodd_append;data{i}];
                odd = odd + dataodd_new;
                count_odd = count_odd + 1;
            elseif strcmp(id{4},'Even')
                for j = 1:length(data)
                    if strcmp(ID{j}{5},type) && check
                        dataeven_append = data{j}(1:8000,:);
                        check = false;
                    end
                end
                dataeven_new = [dataeven_append;data{i}];
                even = even + dataeven_new;
                count_even = count_even + 1;
            end
        end
    elseif m == 25001
        if strcmp(id{5},type)
            if strcmp(id{4},'Odd')
                dataodd_new = [data{i}(1:19000,:);data{i}(19501:22500,:);data{i}(23001:end,:)];
                odd = odd + dataodd_new;
                count_odd = count_odd + 1;
            elseif strcmp(id{4},'Even')
                dataeven_new = [data{i}(1:19000,:);data{i}(19501:22500,:);data{i}(23001:end,:)];
                even = even + dataeven_new;
                count_even = count_even + 1;
            end
        end
    end
end

odd_0 = odd(1:m/3,:)/count_odd;
odd_15 = odd(m/3+1:m*2/3,:)/count_odd;
odd_25 = odd(m*2/3+1:end,:)/count_odd;

even_0 = even(1:m/3,:)/count_even;
even_15 = even(m/3+1:m*2/3,:)/count_even;
even_25 = even(m*2/3+1:end,:)/count_even;

count_even = 1;
count_odd = 1;

for i = 1:length(odd_0)/500
    odd_0_new(i,:) = mean(odd_0(500*(i-1)+1:500*i,:));
    odd_15_new(i,:) = mean(odd_15(500*(i-1)+1:500*i,:)); 
    odd_25_new(i,:) = mean(odd_25(500*(i-1)+1:500*i,:)); 
    
    even_0_new(i,:) = mean(even_0(500*(i-1)+1:500*i,:));
    even_15_new(i,:) = mean(even_15(500*(i-1)+1:500*i,:)); 
    even_25_new(i,:) = mean(even_25(500*(i-1)+1:500*i,:)); 
end

all_0 = [];
all_15 = [];
all_25 = [];

for i = 1:32
    if mod(i,2) == 0
        all_0 = [all_0 ; even_0_new(count_even,:)];
        all_15 = [all_15 ; even_15_new(count_even,:)];
        all_25 = [all_25 ; even_25_new(count_even,:)];
        count_even = count_even + 1;
    else
        all_0 = [all_0 ; odd_0_new(count_odd,:)];
        all_15 = [all_15 ; odd_15_new(count_odd,:)];
        all_25 = [all_25 ; odd_25_new(count_odd,:)];
        count_odd = count_odd + 1;
    end
end

wing.v0.p_inf = all_0(:,1); % static pressure, Pa
wing.v0.rho = all_0(:,3); % density, kg/m^3
wing.v0.v = all_0(:,4); % velocity, m/s
wing.v0.pitot = all_0(:,5); % pitot pressure, Pa
wing.v0.alpha = all_0(:,23); % Angle of attack, deg
wing.v0.N = all_0(:,24);
wing.v0.A = all_0(:,25); 
wing.v0.M = all_0(:,26); 

wing.v15.p_inf = all_15(:,1); % static pressure, Pa
wing.v15.rho = all_15(:,3); % density, kg/m^3
wing.v15.v = all_15(:,4); % velocity, m/s
wing.v15.pitot = all_15(:,5); % pitot pressure, Pa
wing.v15.alpha = all_15(:,23); % Angle of attack, deg
wing.v15.N = all_15(:,24);
wing.v15.A = all_15(:,25); 
wing.v15.M = all_15(:,26); 

wing.v25.p_inf = all_25(:,1); % static pressure, Pa
wing.v25.rho = all_25(:,3); % density, kg/m^3
wing.v25.v = all_25(:,4); % velocity, m/s
wing.v25.pitot = all_25(:,5); % pitot pressure, Pa
wing.v25.alpha = all_25(:,23); % Angle of attack, deg
wing.v25.N = all_25(:,24);
wing.v25.A = all_25(:,25); 
wing.v25.M = all_25(:,26); 

cd (oldFolder)
end