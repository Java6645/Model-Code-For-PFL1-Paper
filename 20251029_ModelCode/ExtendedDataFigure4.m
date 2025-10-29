%Run Circuit Model and true coordinate transformation over every
%combination of head and stored directions
head = [-180:180];
ref = [-180:180];
for j = 1:length(ref)
    HO = model(head,ref(j));
    H(:,j,1)=HO{1}.LAL;
    H(:,j,2)=HO{2}.LAL;
    for i = 1:length(head)
        Right(i,j) = cos(deg2rad(ref(j)-head(i)+45));
        Left(i,j) = sin(deg2rad(ref(j)-head(i)+45));
    end
end

for i=1:length(head)
    for j=1:length(ref)
        %calculate cosine similarity
        CS(i,j) = (H(i,j,1)*Right(i,j)+H(i,j,2)*Left(i,j))/(sqrt(H(i,j,1)^2+H(i,j,2)^2)*sqrt(Right(i,j)^2+Left(i,j)^2));
        %calculate angular difference
        DF(i,j) = mod(rad2deg(atan2(H(i,j,2),H(i,j,1))-atan2(Left(i,j),Right(i,j)))+180,360)-180;
    end
end
%plot D
figure
imagesc(CS)
colorbar
clim([-1 1])
%plot E
figure
imagesc(DF)
colorbar

Side{1}="Right";
Side{2}="Left";

%plot C
for i =1:2
    figure
    imagesc(H(:,:,i))
    colorbar
    clim([-4 4])
    title(['Circuit Model' Side{i}])
end

%plot B
figure
imagesc(Right(:,:))
colorbar
title(['Analytical Prediction Right'])
figure
imagesc(Left(:,:))
colorbar
title(['Analytical Prediction Left'])
