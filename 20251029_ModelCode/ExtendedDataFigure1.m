%Run Hemibrain and FLywire Models over every combination of head and stored
%direction
head = [-180:180];
ref = [-180:180];
for j = 1:length(ref)
    HO = model(head,ref(j));
    FWO = model_FW(head,ref(j));
    H(:,j,1)=HO{1}.LAL;
    H(:,j,2)=HO{2}.LAL;
    FW(:,j,1)=FWO{1}.LAL;
    FW(:,j,2)=FWO{2}.LAL;
end

for i=1:length(head)
    for j=1:length(ref)
        %Calculate Cosine Similarity
        CS(i,j) = (H(i,j,1)*FW(i,j,1)+H(i,j,2)*FW(i,j,2))/(sqrt(H(i,j,1)^2+H(i,j,2)^2)*sqrt(FW(i,j,1)^2+FW(i,j,2)^2));
        %Calculate Angular Difference
        DF(i,j) = mod(rad2deg(atan2(H(i,j,2),H(i,j,1))-atan2(FW(i,j,2),FW(i,j,1)))+180,360)-180;
    end
end
%Plot E
figure
imagesc(CS)
colorbar
clim([-1 1])
title('Cosine Similarity')
%Plot F
figure
imagesc(DF)
colorbar
title('Angular Difference')

Side{1}="Right";
Side{2}="Left";
for i =1:2
    %Plot D Bottom
    figure
    imagesc(H(:,:,i))
    colorbar
    clim([-4 4])
    title(['Hemibrain' Side{i}])
    %Plot D Top
    figure
    imagesc(FW(:,:,i))
    colorbar
    clim([-4 4])
    title(['Flywire' Side{i}])
end