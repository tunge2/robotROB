zz = [0;0;0]; ex = [1;0;0]; ey = [0;1;0]; ez = [0;0;1];
L0=110; L1=137; L2=160; L3=50; L4=40;
% P
p01=0*ex+L0*ez;
p12=zz;
p23=L1*ez;
p34=L2*ex;
p4T=L3*ex-L4*ez;

% H
h1=ez; h2=ey; h3=ey; h4=ey;

dobot.P=[p01 p12 p23 p34 p4T]/1000;
dobot.H=[h1 h2 h3 h4];
dobot.joint_type=[0 0 0 0 0 0];

q = zeros(4,1);
dobot.q = q;
q(1:3)=(rand(3,1)-0.5)*2*pi;q(4)=-(q(2)+q(3));
dobot.q =q;
disp(dobot.q)

dobot=fwdkiniter(dobot);
disp(dobot.T(1:3,4));
dobot = invkinelbow(dobot);


function robot=invkinelbow(robot)
 zz = [0;0;0]; ex = [1;0;0]; ey = [0;1;0]; ez = [0;0;1];
 h1=ez; h2=ey; h3=ey; h4=ey;
 T = robot.T ;
 R0T =robot.T(1:3, 1:3); p0T = T(1:3,4);
 p01 = robot.P(:,1);
 p12 = robot.P(:,2);
 p23 = robot.P(:,3);
 p34 = robot.P(:,4);
 p4T = robot.P(:,5);
 
 q1sol =(subprob4(-ez, ey, p0T-p01, ey'*(p23+p34+p4T)));
 for i=1:2
  q3sol(:,i) = subprob3(ey, -p34, p23, norm(rot(h1, -q1sol(i))*(p0T-p01)-p4T));
    for j = 1:2
     q2sol(j,i) = subprob1(ey,p23+rot(h3,q3sol(j,i))*p34, rot(h1,-q1sol(i))*(p0T-p01)-p4T);
    end
 end
 qsol = [q1sol(1) q1sol(1) q1sol(2) q1sol(2); q2sol(1,1) q2sol(2,1) q2sol(1,2) q2sol(2,2); q3sol(1,1) q3sol(2,1) q3sol(1,2) q3sol(2,2)];
 qsol(4,:)=-(qsol(3,:)+qsol(2,:));
 qsol = qsol
end 

function R=rot(k,theta) 
  
  k=k/norm(k);
  R=eye(3,3)+sin(theta)*hat(k)+(1-cos(theta))*hat(k)*hat(k);
  
end

function khat = hat(k)
  
  khat=[0 -k(3) k(2); k(3) 0 -k(1); -k(2) k(1) 0];
  
end

function q= anglerange1(q)
    q1 = (abs(q)>pi).*(q-sign(q-pi)*2*pi)+(abs(q)<=pi).*q;
end




