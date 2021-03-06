
function [alpha,threshold,rankfeat]=rankboostAUC(xapp,yapp,T);

%  USAGE
%
% [alpha,threshold,rankfeat]=rankboostAUC(xapp,yapp,T);
%
%  This a Rankboost algorithm as described in the freund et al
%  Journal of Machine Learning Research paper.
%  
%  xapp and yapp are the learning set data and labels
%  T is the number of weak learners which is a step function.
%
%  the outputs are 
%  
%   alpha  : vector  of weigth of each weak learner
%   threshold : vector of each weak learner translation
%   rankfeat : vector of each weak learner feature.
%
%  see also rankboostAUCval

% 30/07/2004  A. Rakotomamonjy
%
%



[n,dim]=size(xapp);
indpos=find(yapp==1);
npos=length(indpos);
indneg=find(yapp==-1);
nneg=length(indneg);
yapp=[yapp(indpos);yapp(indneg)];    % on remet les donn?es en ordre!
xapp=[xapp(indpos,:);xapp(indneg,:)];
indpos=find(yapp==1);
indneg=find(yapp==-1);

% dans les vecteurs on stocke d'abord les v(xo) puis les v(x1) xo c'est les
% pos et x1 les neg par rapport ? yapp (voir papier de freund ou on cherche
% h(xo)>h(x1)
%v=ones(n,1)/sqrt(npos*nneg); %v=[v(xo);v(x1)]
v=[1/npos*ones(npos,1);1/nneg*ones(nneg,1)];
s=-yapp; % s=[s(xo);s(x1)];
% D


% pos : xo    neg x1

for i=1:T
    
    
    %   WEAK_LEARNER 
    vpos=sum(v(indpos)); % Equ 6. du proc ICML 
    vneg=sum(v(indneg)); %  Equ 6. du proc ICML 
    d=v .*[vneg*ones(npos,1);vpos*ones(nneg,1)]; 
    mpi= s.*d;  % Definition de pi(x) Paragraphe en dessous equ. 8
    
    % les ranking features c'est les dimensions
    rmax=-inf;
    for j=1:dim % on regarde les ranking feature
        fj=xapp(:,j);
        [sortedfj,indicesorted]=sort(fj) ;% les ranking sont tri?s ... Sorting features
        sortedfj=flipud(sortedfj);
        theta2=[inf;sortedfj- min(abs(diff(sortedfj)))/2]; % candidate threshold = inf U ranked feature + chouia 
        J=length(sortedfj);
        
        for k=1:length(fj) % create  the candidate thresholds
            if k>1
                theta(k)=(sortedfj(k)+sortedfj(k-1))/2;
            else
                theta(k)=sortedfj(1)-1;
            end;
            r(k)=sum(mpi(find(fj>theta(k))));
        end;
        
        
        
        [rmaxaux,goodthresh]=max(abs(r));
        if rmaxaux>rmax     
            rmax=rmaxaux;
            rt=r(goodthresh);
            threshold(i)=theta(goodthresh);  
            if abs(abs(rt)-1) < 0.00001
                rt=sign(rt)*0.99999;
            end;
            alpha(i)=0.5*log((1+rt)/(1-rt));
            rankfeat(i)=j;
        end;
        
    end;
    
    % ----------------- UPDATE De V
    v1=v(indneg).*exp(-alpha(i)*(xapp(indneg,rankfeat(i))>threshold(i)));
    v0=v(indpos).*exp(alpha(i)*(xapp(indpos,rankfeat(i))>threshold(i)));
    if sum(v0)==0 || sum(v1)==0
        v=[v0;v1];
    else
        v=[v0/sum(v0);v1/sum(v1)];
    end;
    
end;

alpha=-alpha; % this is due to the fact that s=-yapp so the sign of alpha makes
% the positive examples negative!!  
