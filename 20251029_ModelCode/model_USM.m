function out = model_USM(head,goal)
%Model using Unsigned Multiplication as the activation function and preferred
%head directions from the hemibrain
load PBprefHead.mat
load LeftFBprefRef.mat
load RightFBprefRef.mat


for j = 1:length(head)
    phiright = PBprefHead([3:8,10]);
    phileft = PBprefHead([9,11:16]);

    PBright=cos(deg2rad(head(j)-phiright))+1;
    PBleft=cos(deg2rad(head(j)-phileft))+1;

    FBright = cos(deg2rad(goal-RightFBprefRef))+1;
    FBleft = cos(deg2rad(goal-LeftFBprefRef))+1;

    Right(j) = sum(FBright.*PBright);
    Left(j) = sum(FBleft.*PBleft);

    out{1}.PB(:,j) = PBright;
    out{1}.FB(:,j) = FBright;
    out{2}.PB(:,j) = PBleft;
    out{2}.FB(:,j) = FBleft;
end

out{1}.LAL = Right;
out{2}.LAL = Left;
