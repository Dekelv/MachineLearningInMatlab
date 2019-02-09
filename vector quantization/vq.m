%%Vector Quantization with winner takes all

%load data
load('w6_1x.mat');

%determine variables
n=size(w6_1x,2);
p=size(w6_1x,1);

%set parameters
k=4;
eta=0.00005;
t_max=100;

%initialize prototype vectors get k random samples
w=zeros(k);
w=datasample(w6_1x,k);

%begin h_vq as a func of t plot
figure
hold on;

%for all epochs
for t=1:t_max
    %shuffle dataset
    aux=randperm(p);
    %reset hvq
    h_vq=0;
    %perf 1 epoch of training
    for i=1:p
        %get shuffled values based on aux
        xi= w6_1x(aux(i),:);
        
        %calculate distances
        diss1 = pdist2(xi,w(1,:),'squaredeuclidean');
        diss2 = pdist2(xi,w(2,:),'squaredeuclidean');
        
        %compare distances, update vector and h_vq
        if(diss1<diss2)
            w(1,:) = w(1,:) + eta*(xi-w(1,:));  
            h_vq=h_vq+diss1;
        else
            w(2,:) = w(2,:) + eta*(xi-w(2,:));
            h_vq=h_vq+diss2;
        end
    end
    %plot new hvq point
    plot(t,h_vq,'x');
end

%labels for first plot
title('Quantization error as a function of t');
xlabel('Epoch (t)');
ylabel('Quatization error value');
legend('quantization error(Hvq)');

%plot dataset and final winners
figure
plot(w6_1x(:,1),w6_1x(:,2),'bx');
hold on;
plot(w(:,1),w(:,2),'r*');
title('Original dataset vs winners');
xlabel('Value');
ylabel('');
legend('dataset entry','winner');

