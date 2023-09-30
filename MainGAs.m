clc;
clear;
close all;
%% Problem Definition for Tests
% File names where fname is declared: analyzeMutant, Evaluates, MinOne,
% MinOne_t, 
%fname='quadraticSolver.m';
%fname='tritype.m';
% Subject programs: sumOfRoots, MID,
% tritype,bisection,gcdFinder,LineRectangleClassifier,my_conv,pdfKernel,PointCircleClassifier,
% triQuad, 
fname='sumOfRoots.m'; 
%fname='sumRoots.m';
result = inputdlg('Enter number of input in program: ','Input');
result = str2double(result);
%pp = cell(result,1);
%pp = zeros(result,1);
prompt = {'Enter the number of rows: ','Enter the number of columns: '};
defaultans = {'1','1'};
total=0;
inputDim = zeros(result,2); % Inputs dimensions
for i=1:result
    dim = inputdlg(prompt,'Input Dimensions',1,defaultans);
    pdt = prod(str2double(dim));
    inputDim(i,1) = str2double(dim(1));
    inputDim(i,2) = str2double(dim(2));
    total = total + pdt;
end

%fname='triQuad.m';
%fname = 'PointCircleClassifier.m';
CostFunction_t=@(fname,mutants,tcase)MinOne_t(fname,mutants,tcase);     % Tester Cost Function
nVar_t = testChromLength(inputDim); % Number of Decision Variables for test cases
%nVar_t=19;            % Number of Decision Variables
VarSize_t=[1 nVar_t];   % Decision Variables Matrix Size

% Problem Definition for Mutants
CostFunction=@(fname,mutant,testcases)MinOne(fname,mutant,testcases);     % Mutant Cost Function
num = numel(de2bi(numOfLines(fname)));
nVar=num+3;            % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
disp('...Initializing...');

%% GAs Parameters
MaxIt=250;	% Maximum Number of Iterations
nPop=20;	% Test Population Size
mnPop=20;   % Mutant Population Size
%nElite = 0;
nElite = round(0.05*nPop); % Elite Size
pc=0.8;                 % Crossover Percentage
%nc=2*round(pc*nPop/2);  % Number of Offsprings (also Parents)
nc=round(pc*(nPop-nElite));
%nc=(nPop-nElite);  % Number of Offsprings (also Parents)
pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants
mu=0.02;                % Mutation Rate

beta=8;         % Selection Pressure
TournamentSize=3;   % Tournamnet Size

pause(0.01); % Needed due to a bug in older versions of MATLAB

%% Initialization
% Tester GA
empty_individual_t.Position=[];
empty_individual_t.Cost=[];

pop_t=repmat(empty_individual_t,nPop,1);
tests=cell(nPop,1);

for i=1:nPop
    % Initialize Position
    pop_t(i).Position=randi([0 1],VarSize_t);    
    tests{i}=pop_t(i).Position;
end
bc_t=0;

% Initialization of the probability tables
%probVal = 
nLines = numOfLines(fname);
A=[];
nOp = 2;
lineVal = repmat(A,nLines,2);
for i=1:nLines
    lineVal(i,1)=1;
    lineVal(i,2)=1;
end
opVal=cell(2,2);
opVal{1,1} = 'AOR';
opVal{2,1} = 'ROR';
%opVal = repmat(opeVal,nOp,1);
increments=zeros(MaxIt,2);

B=[];
chVal = repmat(B,5,2);% Choice value (e.g. for arith: +,-,*,/,^)
for j=1:5
    chVal{j,1} = 1;
    chVal{j,2} = 1;
end

for j=1:nOp
    opVal{j,2} = 0.5;
end

   
% Mutating GA
temp.Position=[];
%temp.Test=[];
empty_individual.Position=[];
empty_individual.Cost=[];
%empty_individual.Gen=[];

tpop=repmat(temp,mnPop,1);% Temporary mutant population
tpop_t=repmat(temp,nPop,1); % Temporary test population
pop=repmat(empty_individual,mnPop,1);
mutants=cell(mnPop,1);
for i=1:mnPop
    % Initialize Position
    %pop(i).Position=randMutantGen(fname);
    tpop(i).Position=randMutantGen(fname); % Temporary population for the next iteration
    %pop(i).Position=randi([0 1],VarSize);
    %mutants{i}=pop(i).Position;
    mutants{i}=tpop(i).Position;
    %disp(mutants{i});

end
bc=nPop*mnPop;


%% 
% Array to Hold Best Test Cost Values
BestCost_t=zeros(MaxIt,1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

prob=zeros(MaxIt,2);
normProb=zeros(MaxIt,2);
numKilled=zeros(MaxIt,1);
numOfUniqMut=zeros(MaxIt,1);
listOfKilled=[];
listOfGenMutants=[];
killedMutants=zeros(MaxIt,1);
tgm = zeros(MaxIt,1);% Total generated mutants
totalKilledMutants=0;
prop = zeros(MaxIt,1); % proportion of killed mutants
%% Main Main Loop
for it=1:MaxIt

    % Array to hold the number of mutant sample in each iteration
    nMutSamp=zeros(length(opVal),1);
    for i=1:mnPop
        pop(i).Position=tpop(i).Position; % Temporary struct
        
    end
    

    %EVALUATION
    % Tests Evaluation
    test_Matrix=zeros(mnPop,nPop);
    for i=1:nPop
        tcase=pop_t(i).Position;
        [pop_t(i).Cost,~,test_Matrix(:,i)]=CostFunction_t(fname,mutants,tcase);
        
    %    [pop_t(i).Cost,nkilled]=CostFunction_t(fname,mutants,tcase);
    end

    num_mut_sample=zeros(length(opVal),1);
    tot_test = sum(test_Matrix);
    
    for i=1:mnPop
        mutant=pop(i).Position;
        %pop(i).Cost=CostFunction(fname,mutant,tests);
        muTotal = sum(test_Matrix(i,:));
        pop(i).Cost = mnPop*nPop - sum(muTotal*test_Matrix(i,:));
        
    end

    %% Crossovers
    %% Tests Crossover
    popc_t=repmat(empty_individual_t,round(nc/2),2);
    testsc=cell(round(nc/2),2);

    %P_t=exp(-beta*Values_t/worstValue_t);
    %P_t=P_t/sum(P_t);
    for k=1:(nPop-nElite)/2
    %for k=1:nPop/2
        i1_t=TournamentSelection_t(pop_t,TournamentSize);
        i2_t=TournamentSelection_t(pop_t,TournamentSize);
        %i1_t=RouletteWheelSelection(P_t);
        %i2_t=RouletteWheelSelection(P_t);

        % Select Parents
        p1_t=pop_t(i1_t);
        p2_t=pop_t(i2_t);
        % Perform Test Crossover
        [popc_t(k,1).Position, popc_t(k,2).Position]=Crossover_t(p1_t.Position,p2_t.Position);
        %[popc_t(k,1).Position, popc_t(k,2).Position]=DoublePointCrossover_t(p1_t.Position,p2_t.Position);
        % Evaluate Test Crossover Offspring
    %     tcase1=popc_t(k,1).Position; %testsc{k,1};
    %     tcase2=popc_t(k,2).Position; %testsc{k,2};
    %     popc_t(k,1).Cost=CostFunction_t(fname,mutants,tcase1);%popc_t(k,1).Position);% COMMENTED
    %     popc_t(k,2).Cost=CostFunction_t(fname,mutants,tcase2);
    end
    popc_t=popc_t(:);

    %% Tests Mutation
    popm_t=repmat(empty_individual_t,nm,1);
    for k=1:nm
        % Select Parent to mutate
        i=randi([1 nPop]);
        p_t=pop_t(i);

        % Perform Test GA Mutation
        popm_t(k).Position=Mutate_t(p_t.Position,mu);

        % Evaluate Test Mutant
        % popm_t(k).Cost=CostFunction_t(fname,mutants,popm_t(k).Position); %COMMENTED
    end


    %% Mutants Crossover
    popc=repmat(empty_individual,round(nc/2),2);
    mutantsc=cell(round(nc/2),2);
    %P=exp(-beta*Values/worstValue);
    %P=P/sum(P);
    %for k=1:round((mnPop-nElite)/2)
    for k=1:(mnPop-nElite)/2
        % Mutants Crossover
        i1=TournamentSelection(pop,TournamentSize);
        i2=TournamentSelection(pop,TournamentSize);
        %i1=RouletteWheelSelection(P);
        %i2=RouletteWheelSelection(P);


        % Select Mutant Parents
        p1=pop(i1);
        p2=pop(i2);
        % Perform Mutant Crossover
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position);
        %[popc(k,1).Position, popc(k,2).Position]=DoublePointCrossover(p1.Position,p2.Position);
        % Evaluate Mutant Offspring
        mutant1=popc(k,1).Position;%mutantsc{k,1};
        mutant2=popc(k,2).Position;%mutantsc{k,2};
    %     popc(k,1).Cost=CostFunction(fname,mutant1,tests);
    %     popc(k,2).Cost=CostFunction(fname,mutant2,tests);
    end
    popc=popc(:);

    %% Mutants Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        % Select Parent to mutate
        i=randi([1 mnPop]);
        p=pop(i);

        % Perform Mutant GA mutation
        popm(k).Position=Mutate(p.Position,mu);

        %Evaluate Mutant Mutant
    %    popm(k).Cost=CostFunction(fname,popm(k).Position,tests);
    end

    % Create Merged Population
    Elites=pop(1:nElite);
    pop=[Elites
        popc
        popm];

    for i=1:length(pop)
        mutant=pop(i).Position;
        pop(i).Cost=CostFunction(fname,mutant,tests);

    end

    % Sort evaluated mutants
    Costs=[pop.Cost];
    [Costs,sortOrder]=sort(Costs,'ascend');
    pop=pop(sortOrder);
    % Truncation
    pop=pop(1:mnPop);
    Costs=Costs(1:mnPop);

    %% Tests Merging & evaluation
    %popc_t=popc_t(:);
    %tests=testsc(:);
    Elites_t = pop_t(1:nElite);
    pop_t=[Elites_t
          popc_t
          popm_t]; % #ok

    testMatrix=zeros(mnPop,nPop);
    %testMatrix = [];
    tVec=[];
    choiMat=zeros(5,4);
    
    for i=1:length(pop_t)
        tcase=pop_t(i).Position;
        tpop_t(i).Position=pop_t(i).Position;
        %[pop_t(i).Cost,nkilled,tVec,chMat]=CostFunction_t(fname,mutants,tcase);
        [~,nkilled,testMatrix(:,i),chMat]=CostFunction_t(fname,mutants,tcase);
        %[pop_t(i).Cost,nkilled,testMatrix(:,i),chMat]=CostFunction_t(fname,mutants,tcase);
    %     delayance=2*2;
    %     delayance=delayance + squ(2);
        choiMat=choiMat + chMat;

        tVec=[];

    end
    choiMat=choiMat/length(pop_t);

    arithChoiProp=choiMat(:,2)./choiMat(:,1);
    relChoiProp=choiMat(:,4)./choiMat(:,3);

    arithChProb = arithChoiProp/sum(arithChoiProp);

    relChProb = relChoiProp/sum(relChoiProp);

    testMatrix = testMatrix(1:mnPop,1:nPop);
    %chCumProb=zeros(5,2);
    


    % Evaluate the Test cases based on the test execution matrix
    fitness = testEval(testMatrix); 
    %for k=1:length(pop_t)
    for k=1:nPop
       pop_t(k).Cost=fitness(k);
    end

    % Sort evaluated tests
    Costs_t=[pop_t.Cost];
    [Costs_t, SortOrder]=sort(Costs_t, 'descend');
    pop_t=pop_t(SortOrder);
    % Truncation
    pop_t=pop_t(1:nPop);
    Costs_t=Costs_t(1:nPop);

    %Store Test Best Solution
    BestSol_t=pop_t(1);
    %      Elites_t = pop_t(1:nElite);


    %% 
        % Compute the number of mutant sample for each mutation operator
    for i=1:mnPop
        mutchr=pop(i).Position;
        if mutchr(1)==0
            nMutSamp(1) = nMutSamp(1) + 1;
        else
            nMutSamp(2) = nMutSamp(2) + 1;
        end
    end

    % Update the probabilities of the mutation operators
    for i=1:size(opVal,1) % For each row of opVal
        incr = 2*((nMutSamp(i) - nkilled(i))/nMutSamp(i))-1;
    %    if(i==1)
            opVal{i,2} = opVal{i,2} + (incr/(mnPop*MaxIt));
            %opVal{i+1,3} = opVal{i,3} - (incr/(mnPop*MaxIt));
    %     else
    %         
    %     end
    %     
        increments(MaxIt,i)=incr/(mnPop*MaxIt);
    end
    prob(it,1) = opVal{1,2};
    prob(it,2) = opVal{2,2};

    % Update the probabilities of the line numbers
    
%%
    % Store Mutant Best Solution
    %BestSol=pop(1);


    for i=1:length(pop_t)
        tests{i}=pop_t(i).Position; 
    end

    if(bc_t<pop_t(1).Cost)
        %bc_t=BestSol_t.Cost;
        bc_t=pop_t(1).Cost;
    end

        % Store Best Cost Ever Found
    BestCost_t(it)=bc_t;

    disp(['Iteration ' num2str(it) ': Best Test Value = ' num2str(BestCost_t(it))]);


    BestSol=pop(1);
    if(bc >= pop(1).Cost)
        bc = pop(1).Cost;
    end

      % Store Best Cost Ever Found
    BestCost(it)=bc;



    disp(['Iteration ' num2str(it) ': Best Mutant Cost = ' num2str(BestCost(it))]);
        %disp(['Iteration ' num2str(it) ': Number of Mutants = ' num2str(length(pop))]);


    %% Evaluate and collect the unkilled mutants
    
    mutKillMatrix = any(testMatrix,2); % A column VECTOR to show if a mutant is killed or not
    killedMut = find(mutKillMatrix==1);
    unkilledMut=find(mutKillMatrix==0);
    num_unkill=sum(mutKillMatrix==0);
    num_kill=sum(mutKillMatrix==1);
    numKilled(it)=num_kill;
    pp.Position=[]; pp.Value=[];
    unkill=repmat(pp,num_unkill,1);
    
    % List of total generated unique mutants
    kount=0;
    for i=1:mnPop
        kk=convertMut(pop(i).Position);
        if(isempty(find([listOfGenMutants]==kk,1)))
        %if(~ismember(kk,listOfGenMutants))
            listOfGenMutants(end+1)=kk;
            kount = kount +1;
        end
    end
    numOfUniqMut(it)=kount;
    totalKilledMutants = totalKilledMutants + kount;
    tgm(it)=totalKilledMutants;
    
    
    kounter=0;
    for i=1:length(killedMut)
        ind=killedMut(i);
        jj=convertMut(pop(ind).Position);
        if(isempty(find([listOfKilled]==jj,1)))
        %if(~ismember(kk,listOfKilled))
            listOfKilled(end+1)=jj;
            kounter = kounter +1;
        end
    end
    killedMutants(it)=length(listOfKilled);
    
    % Find the proportion
%     prop(it) = killedMutants(it)/tgm(it)*100;
    
    for i=1:num_unkill
        j=unkilledMut(i);
        unkill(i).Position=pop(j).Position;
        unkill(i).Value=convertMut(pop(j).Position);
        
    end
    rem_Mut=mnPop-num_unkill; % Number of remaining mutants to complete the set of mutants.
    % Store killed mutants
%     for k=1:nPop
%         converted = convertMut(pop(k).Position);
%         killed = 0;
%     end
    
    for i=1:num_unkill
        tpop(i).Position=unkill(i).Position;
    end
    


    normProb(it,1)=prob(it,1)/sum(prob(it,:));
    normProb(it,2)=prob(it,2)/sum(prob(it,:));
    % sort the content of normProb
    [normProb_it, op_ind]= sort(normProb(it,:),'ascend');
    % if op_ind = [ 2 1] then the first operator is the ROR while the first one
    % is AOR


    %% Generate new mutant populations
    mutNo=rem_Mut+1;
    while (mutNo<=mnPop)
        oprandi = rand;
        chrandi = rand;
        opscore=normProb(it,:);
        
        %[opscore,op_ind]=sort(opscore);
            
        chscore=0; % Check later
        if(op_ind(1)==1)
            oplist=ArithMutStmt(fname);
            if oprandi <= opscore(op_ind(1))
                tpop(mutNo).Position=[0 randi([0 1],[1 num+2])];
            else
                tpop(mutNo).Position=[1 randi([0 1],[1 num+2])];
            end
        else
            if oprandi <= opscore(op_ind(1))
                tpop(i).Position=[1 randi([0 1],[1 num+2])];
            else
                tpop(i).Position=[0 randi([0 1],[1 num+2])];
            end
        end
        mutNo = mutNo + 1;
    end
    
    for i=1:length(tpop)
        mutants{i} = tpop(i).Position;
    end



end
prop = killedMutants./tgm;
testMat=randi([0 1],30,30);
mutscore=min(prop);
% Normalize probabilities
%normProb=zeros(2,1);
%normProb(1)=prob(end,1)/sum(prob(end,:));
%normProb(2)=prob(end,2)/sum(prob(end,:));
disp(normProb);
% Write to file
% Mutants score
    % writeFile('result.txt',num2str(mutscore));
% Write test score
%writeFile('result.txt',num2str(bc_t));
%% Visualization
disp('Completed');
% figure;
% plot(BestCost_t,'LineWidth',1);
% title('Plot of best test values');
% xlabel('Number of Generation');
% ylabel('Best Test Value');
% grid on;
% pause(3);
% figure;
% plot(BestCost,'LineWidth',1);
% title('Plot of best mutant cost');
% xlabel('Number of Generation');
% ylabel('Cost of Mutants');
% grid on;
% pause(5);
figure;
plot(normProb,'LineWidth',1);
title('Plot of the Probability of killing mutant operators');
xlabel('Number of Generation');
ylabel('Probability of killing');
grid on;
figure;
plot(killedMutants);
title('Plot of the Total number of mutant Gen & killed');
xlabel('Number of Generation');
ylabel('Number of Generated & killed Mutants');
hold on;
plot(tgm);
% hold on;
% plot(prop);
figure;
plot(prop);
title('Plot of the percentage of killed mutants');
xlabel('Number of Generation');
ylabel('Percentage of killing');
figure;
plot(numOfUniqMut);
title('Plot of the Number of unique tested mutants');
xlabel('Number of Generation');
ylabel('Number of unique mutants');