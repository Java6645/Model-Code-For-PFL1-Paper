%Run Signed Multiplication, Unsigned Multiplication, and Sum of Square Models over every combination of head and stored
%direction
head = [-180:180];
ref = [-180:180];
for j = 1:length(ref)
    SMo = model(head,ref(j));
    SM(:,j,1)=SMo{1}.LAL;
    SM(:,j,2)=SMo{2}.LAL;
    USMo = model_USM(head,ref(j));
    USM(:,j,1)=USMo{1}.LAL;
    USM(:,j,2)=USMo{2}.LAL;
    SSo = model_SOS(head,ref(j));
    SS(:,j,1)=SSo{1}.LAL;
    SS(:,j,2)=SSo{2}.LAL;
end
Side{1}="Right";
Side{2}="Left";

for i =1:2
    %plot B
    figure
    imagesc(SM(:,:,i))
    colorbar
    title(['Signed Multiplication' Side{i}])
    %plot D
    figure
    imagesc(USM(:,:,i))
    colorbar
    title(['Unsigned Multiplication' Side{i}])
    %plot F
    figure
    imagesc(SS(:,:,i))
    colorbar
    title(['Sum of Square' Side{i}])
end


%Calculate Individual Neuron Responses for each activation function over a
%range of PB and FB inputs
x = [-1:0.1:1];
y=[-1:0.1:1];
for j =1:length(x)
    iSM(j,:) = x(j)*y;
    iUSM(j,:)=(x(j)+1)*(y+1);
    for i=1:length(y)
        iSS(j,i)=(x(j)+y(i))^2;
        iS(j,i)=(x(j)+y(i));
    end
end

colors = parula(length(x));

for j = 1:length(x)
    %plot A
    figure(101)
    plot(y,iSM(j,:),'Color',colors(j,:))
    hold on
    title('Signed Multiplication')
    %plot C
    figure(102)
    plot(y,iUSM(j,:),'Color',colors(j,:))
    hold on
    title('Unsigned Multiplication')
    %plot E
    figure(103)
    plot(y,iSS(j,:),'Color',colors(j,:))
    hold on
    title('Sum of Square')
end

%Run Model on Example Trial
load exampletrialhead
load exampletrialgoal

SMo = model(head,goal);
USMo = model_USM(head,goal);
SSo = model_SOS(head,goal);



for i = 1:2
    %plot G
    figure
    plot(zscore(SMo{i}.LAL),'Color','#F6DE29')
    hold on
    plot(zscore(USMo{i}.LAL),'Color','#5ACC77')
    plot(zscore(SSo{i}.LAL),'Color','#402AB4')
    hold off
    xlim([1 length(SMo{i}.LAL)])
    ylim([-2.5 2.5])
    title(Side{i})
    %Calculate correlation coefficients in H
    [r1{i},p]=corrcoef(SMo{i}.LAL,USMo{i}.LAL);
    [r2{i},p]=corrcoef(SMo{i}.LAL,SSo{i}.LAL);
    [r3{i},p]=corrcoef(SSo{i}.LAL,USMo{i}.LAL);
end
