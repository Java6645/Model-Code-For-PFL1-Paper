function out = model(head,goal)
%Model using Signed Multiplication as the activation function and preferred
%head directions from the hemibrain
load PBprefHead.mat
load LeftFBprefRef.mat
load RightFBprefRef.mat


for j = 1:length(head)
    phiright = PBprefHead([3:8,10]);
    phileft = PBprefHead([9,11:16]);

    PBright=cos(deg2rad(head(j)-phiright));
    PBleft=cos(deg2rad(head(j)-phileft));

    FBright = cos(deg2rad(goal-RightFBprefRef));
    FBleft = cos(deg2rad(goal-LeftFBprefRef));

    Right(j) = sum(FBright.*PBright);
    Left(j) = sum(FBleft.*PBleft);

    out{1}.PB(:,j) = PBright;
    out{1}.FB(:,j) = FBright;
    out{2}.PB(:,j) = PBleft;
    out{2}.FB(:,j) = FBleft;
end

out{1}.LAL = Right;
out{2}.LAL = Left;
