clc;
clear;
close all;

%% Problem Definition for Tests
fname='quadraticSolver.m';
%fname='tritype.m';
CostFunction_t=@(fname,mutants,tcase)MinOne_t(fname,mutants,tcase);     % Tester Cost Function
nVar_t=12;            % Number of Decision Variables
VarSize_t=[1 nVar_t];   % Decision Variables Matrix Size

% Problem Definition for Mutants

CostFunction=@(fname,mutant,testcases)MinOne(fname,mutant,testcases);     % Mutant Cost Function
num = numel(de2bi(numOfLines(fname)))

nVar=num+3;            % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
disp('...Initializing...');

%% GAs Parameters

MaxIt=20;	% Maximum Number of Iterations

nPop=40;	% Population Size
nElite = 0.2*nPop; % Elite Size
pc=0.8;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (also Parnets)

pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants
mu=0.02;                % Mutation Rate

beta=8;         % Selection Pressure
TournamentSize=3;   % Tournamnet Size


pause(0.01); % Needed due to a bug in older versions of MATLAB

%% Initialization
%% Tester GA
empty_individual_t.Position=[];
empty_individual_t.Cost=[];

pop_t=repmat(empty_individual_t,nPop,1);
tests=cell(nPop,1);
for i=1:nPop
    
    % Initialize Position
    pop_t(i).Position=randi([0 1],VarSize_t);    
    tests{i,1}=pop_t(i).Position;
end

% Mutating GA
empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,nPop,1);
mutants=cell(nPop,1);
for i=1:nPop
    
    % Initialize Position
    pop(i).Position=randi([0 1],VarSize);
    mutants{i,1}=pop(i).Position;
    %disp(mutants{i});

end


%% Main Loop
%% Main Loop for testing
for it=1:MaxIt
    
    %EVALUATION
    % Tests Evaluation
    for i=1:nPop
        tcase=pop_t(i).Position;
        pop_t(i).Cost=CostFunction_t(fname,mutants,tcase);
    end

    % Mutants Evaluation
    for i=1:nPop
        mutant=pop(i).Position;
        pop(i).Cost=CostFunction(fname,mutant,tests); 
    end
    
    % Tests Sorting
    % Sort Test Population
    Costs_t=[pop_t.Cost];
    [Costs_t, SortOrder]=sort(Costs_t, 'descend');
    pop_t=pop_t(SortOrder);

    % Store Test Best Solution
    BestSol_t=pop_t(1);
    Elites_t = pop_t(1:nElite);
    % Array to Hold Best Test Cost Values
    BestCost_t=zeros(MaxIt,1);

    % Store Test Cost
    WorstCost_t=pop_t(end).Cost;
    
    % Mutants Sorting
    % Sort Mutants Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs, 'descend');
    pop=pop(SortOrder);

    % Store Best Solution
    BestSol=pop(1);
    Elites=pop(1:nElite);
    % Array to Hold Best Cost Values
    BestCost=zeros(MaxIt,1);

    % Store Cost
    WorstCost=pop(end).Cost;
    
    % Copied from here inside the main loop
    P=exp(-beta*Costs_t/WorstCost_t);
    P=P/sum(P);
    
    % Tests Crossover
    popc_t=repmat(empty_individual_t,nc/2,2);
    tests=cell(nc/2,2);
    popc=repmat(empty_individual,nc/2,2);
    mutants=cell(nc/2,2);
    
    for k=1:(nPop-nElite)/2
%        if UseTournamentSelection
        i1_t=TournamentSelection_t(pop_t,TournamentSize);
        i2_t=TournamentSelection_t(pop_t,TournamentSize);
        % Select Parents
        p1_t=pop_t(i1_t);
        p2_t=pop_t(i2_t);
        % Perform Test Crossover
        [popc_t(k,1).Position, popc_t(k,2).Position]=Crossover_t(p1_t.Position,p2_t.Position);
        tests{k,1}=popc_t(k,1).Position;
        tests{k,2}=popc_t(k,2).Position;
%     end
%     for k=1:nc/2
        % Mutants Crossover
        i1=TournamentSelection(pop,TournamentSize);
        i2=TournamentSelection(pop,TournamentSize);
        % Select Mutant Parents
        p1=pop(i1);
        p2=pop(i2);
        % Perform Mutant Crossover
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position);
        mutants{k,1}=popc(k,1).Position;
        mutants{k,2}=popc(k,2).Position;
%         popc_t(k,1).Cost=CostFunction_t(popc_t(k,1).Position);
%         popc_t(k,2).Cost=CostFunction_t(popc_t(k,2).Position);        
    end
    %popc_t=popc_t(:);
        
    %Mutants Crossover
%     P=exp(-beta*Costs/WorstCost);
%     P=P/sum(P);
    %popc=popc(:); % Split the (n,2) cell into a (p,1) cell array
    
     for k=1:nc/2
    % Evaluate Offspring
        % Tests Evaluation
        tcase1=tests{k,1};
        tcase2=tests{k,2};
        popc_t(k,1).Cost=CostFunction_t(fname,mutants,tcase1);%popc_t(k,1).Position);
        popc_t(k,2).Cost=CostFunction_t(fname,mutants,tcase2);
        
      % Evaluate Mutant Offsprings
        mutant1=mutants{k,1};
        mutant2=mutants{k,2};
        popc(k,1).Cost=CostFunction(fname,mutant1,tests);
        popc(k,2).Cost=CostFunction(fname,mutant2,tests);
    
     end

        %% Tests Sorting
        
        % Create Merged Tests Population
        popc_t=popc_t(:);
        pop_t=[Elites_t
          popc_t]; %#ok
    
        % Sort Test Population
        Costs_t=[pop_t.Cost];
        [Costs_t, SortOrder]=sort(Costs_t, 'descend');
        pop_t=pop_t(SortOrder);

         % Truncation
         pop_t=pop_t(1:nPop);
         Costs_t=Costs_t(1:nPop);
        
        % Store Test Best Solution ever found
        BestSol_t=pop_t(1);
        
        % Store Best Cost Ever Found
        BestCost_t(it)=BestSol_t.Cost;
        
        disp(['Iteration ' num2str(it) ': Best Test Cost = ' num2str(BestCost_t(it))]);

        
        %% Mutants Sorting
        
        % Create Merged Population
        popc=popc(:);
        pop=[Elites
         popc]; %#ok
     
        % Sort Mutants Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs, 'descend');
        pop=pop(SortOrder);
        
        % Truncation
         pop=pop(1:nPop);
         Costs=Costs(1:nPop);

        % Store Best Solution
        BestSol=pop(1);

        % Store Best Cost Ever Found
        BestCost(it)=BestSol.Cost;
        
%         Store Cost
%         WorstCost=pop(end).Cost;
        disp(['Iteration ' num2str(it) ': Best Mutant Cost = ' num2str(BestCost(it))]);
    
end
disp('Completed');
figure;
plot(BestCost_t,'LineWidth',1);
xlabel('Iteration');
ylabel('Test Cost');
grid on;
pause(2);
figure;
plot(BestCost,'LineWidth',1);
xlabel('Iteration');
ylabel('Mutant Cost');
grid on;