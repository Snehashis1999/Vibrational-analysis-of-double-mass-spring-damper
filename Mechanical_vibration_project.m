global k1 k2 c1 c2 m1 m2

k1=500; %N/m
k2=300; 
c1=8;
c2=3; %N/(m/s)
m1=30;
m2=20;
X1=1; %N
X2=.5;


[t,q] = ode45 (@odev, [0 30], [X1 0 X2 0]);
x2move = q(:,3);
x1move = q(:,1);

len = length(t);

for i = 1: len
    subplot(3,1,1)
    x12 = [x1move(i), x2move(i)-2];
    y12 = [0,0];
    x01 = [2, x1move(i)];
    y01 = [0,0];
    
    
    plot(x2move(i)-2,0,'o','linewidth',m2);
    line(x12, y12,'linewidth',1,'color','k')
    text(x2move(i)-2,.5,['m2'])
    
    hold on
    plot(x1move(i),0,'o','linewidth',m1);
    line(x01, y01,'linewidth',1,'color','k')
    text(x1move(i),.5,['m1'])
    hold off
    
    title('Simulation');
    grid on;
    xlabel('mm')
    ylabel('mm')
    axis([-3.5, 3.5, -1,1])
    drawnow limitrate
    pause(.0005)
    title("Simulation of the system")
    clf;
    
    subplot(3,1,3)
    plot(t(1:i),x2move(1:i))
    xlabel('time')
    ylabel('x2')
    grid on
    axis([0,30,-2,2]);
    title("Responce plot of m_2")
    
    subplot(3,1,2)
    plot(t(1:i),x1move(1:i))
    xlabel('time')
    ylabel('x1')
    grid on
    axis([0,30,-2,2]);
    title("Responce plot of m_1")
end



function dq = odev(~,q)
 global k1 k2 c1 c2 m1 m2

 
 x1 = q(1);
 x1dot = q(2);
 x2 = q(3);
 x2dot = q(4);

 x1dotdot = (k2*(x2-x1)+c2*(x2dot-x1dot)-k1*x1-c1*x1dot)/m1 ;
 x2dotdot = (-k2*(x2-x1)-c2*(x2dot-x1dot))/m2 ;

 dq = [x1dot x1dotdot x2dot x2dotdot]' ;
end