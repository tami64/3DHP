function [ P_best,P_best_pos ] = PSO( GausHist )

% Multimodal PSO
% GausHist = Smoothed 3D histogram
% taymaz.farshi@gmail.com
disp('Multimodal PSO is being started...')

N = 350;              % Size of the swarm " Number of particle "
i_max = 250;         % Iteration Value "particle steps"
theta = 0.82;        % pso momentum or inertia
thetama = 0.98;
thetami = 0.6;
%%    Select Function
XMinMax = [1 256;1 256;1 256];
Eval = @Evaluat3dHist;
dim = 3;

R1 = rand(dim,N);     % PSO parameter R1
R2 = rand(dim,N);     % PSO parameter R2
c1 = 2.15;          % PSO parameter C1
c2 = 2.15;          % PSO parameter C2

%% Initializing

EvalValue = ones(1,N); % Fittnes value for all particle is one
X=rand(dim, N);        % Random Particle Position
for i=1:N
    X(:,i)=X(:,i) .* (XMinMax(:, 2) - XMinMax(:, 1)) + XMinMax(:, 1);
end
P_best_pos = X;   %Best Particle Posation
for i = 1:N
    EvalValue(1,i) = Eval(X(:,i));  %Calculate fitness function(i)
end
V_old = 0.8*randn(dim,N); %initialing Velocity
P_best = EvalValue;                        % initial (local best fitness)
for i=1:N

    F=electrostatic(X,N,i,P_best); %call electrostatic Function
    V_new(:,i) = theta*V_old(:,i) + c1*R1(:,i) .* (P_best_pos(:,i) - X(:,i))+c2*R2(:,i) .* (P_best_pos(:,F) - X(:,i)); %Calculate Velocity;
    X(:,i) = X(:,i)+V_new(:,i); %Move Particle to new Posation;
    V_old(:,i) = V_new(:,i);
    temp =edistance(X,N,i,P_best,c1,c2,XMinMax,P_best_pos,dim);
    if Eval(temp)> P_best(i)
        P_best_pos(:,i)=temp;
    end
end
    X(X<1) = 1;
    X(X>256) = 256;
%%
rr=zeros(1,i_max);
for t = 1 : i_max
    EvalValue(1,:) = Eval(X) ;
    for i = 1 : N
        if EvalValue(1,i) > P_best(i)
            P_best(i) = EvalValue(1,i);
            P_best_pos(:,i) = X(:,i);
        end
    end
    % ************
    theta = thetama-((thetama-thetami)/i_max)*t;
    for i=1:N

        F=electrostatic(X,N,i,P_best);
        V_new(:,i) = theta * V_old(:,i)+c1*R1(:,i) .* (P_best_pos(:,i) - X(:,i))+c2*R2(:,i) .* (P_best_pos(:,F) - X(:,i));
        X(:,i) =X(:,i) + V_new(:,i);
        V_old(:,i) = V_new(:,i);
        temp =edistance(X,N,i,P_best,c1,c2,XMinMax,P_best_pos,dim);
        if Eval(temp)>= P_best(i)
            P_best_pos(:,i)=temp;
        end
%         if (Eval(X(:,i))==0)
%             %             X(:,i)=P_best_pos(:,i);
%             %
%             rrr =round( rand .* (XMinMax(:, 2)-10 - XMinMax(:, 1)+10) + XMinMax(:, 1)+10);
%             rrr =round( rand .* (N-1) + 1);
%             
%             X(:,i)= X(:,rrr);
%             %
%         end
    end
%     X(X<1) = 1;
%     X(X>256) = 256;
    EvalValue(1,:) = Eval(X);
        
end


end
