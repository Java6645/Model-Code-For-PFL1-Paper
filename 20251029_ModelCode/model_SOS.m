function out = model_SOS(head,goal)
%Model using Sum of Square as the activation function and preferred
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
    for i=1:7
        r(i)=(FBright(i)+PBright(i))^2;
        l(i)=(FBleft(i)+PBleft(i))^2;
    end
    Right(j) = sum(r);
    Left(j) = sum(l);

    out{1}.PB(:,j) = PBright;
    out{1}.FB(:,j) = FBright;
    out{2}.PB(:,j) = PBleft;
    out{2}.FB(:,j) = FBleft;
end

out{1}.LAL = Right;
out{2}.LAL = Left;
