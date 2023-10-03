%% Triton_Cluster_KNN.m ͨ��KNN��ȡcandidate lines
% ������Ϣ��DivideAndConquer.m��ȡ
%%
clear all;
close all;
clc;
%% ������Ϣ
NodeInf=xlsread('Triton.xlsx','A1:C92');
left_nodes=[1 2 3 4 5 6 7 8 24 25 26 31 32 37 38 42 43 48 49 53 57 61 62 63 66 69 70 73 77 78 80 82 85 87 91]';
middle_nodes=[9 10 11 12 13 14 15 16 27 28 33 39 44 45 50 54 58 59 64 67 71 74 75 76 79 81 83 84 86 88 89 90 91 92]';
right_nodes=[17 18 19 20 21 22 23 29 30 34 35 36 40 41 46 47 51 52 55 56 60 65 68 72 92]';

%% Cluster1
cluster1=NodeInf(left_nodes,:);
x=cluster1(:,2);
y=cluster1(:,3);
Coor=[x,y];
K=6; % ���������㱾��������ʵֻ����K-1�����ڵ�
[Idx,D] = knnsearch(Coor,Coor,"K",K,"Distance","euclidean");
% Idx contains the node index itself, so delete 1st column.
KNNDis=D(2:K);
figure;
gscatter(Coor(:,1),Coor(:,2));
hold on
for i=1:length(cluster1)
    number=num2str(i); % ���
    text(Coor(i,1),Coor(i,2),number);
end
hold off

Cluster1=[]; %������ѡ��·���ϣ�֮��д��xlsx
J=[]; %��ʼ�ڵ�
I=[]; %��ֹ�ڵ�
len_l=[]; %��ѡ��·����
for i=1:size(Idx,1)
    %     original_index=Idx(i,1);
    %     sort(Idx(i,:));% ��Idx������������
    for j=1:size(Idx,2)
        if Idx(i,j)>i %������ʼ�ڵ�>��ֹ�ڵ���Ž��д洢
            J=[J,Idx(i,j)];
            I=[I,i];
            len_l=[len_l,D(i,j)];
        elseif Idx(i,j)<i % ��K�����г��ֱ������ڵ����С�Ľڵ����ʱ��
            % ���֮ǰ�Ƿ��Ѿ����ֹ����洢����û�д洢�������·�ʽ���д洢
            temp=Idx(i,j);
            temp_index=find(I==temp);
            if J(temp_index)~=i
                J=[J,i];
                I=[I,Idx(i,j)];
                len_l=[len_l,D(i,j)];
            end
        end
    end
end
matching0=[]%Ϊ�˽��KNN����ź�ʵ����ŵĲ�ƥ��
% J=[J,59,59,59];I=[I,31,33,44];
% len_l=[len_l,norm([Coor(59,:),Coor(31,:)]),norm([Coor(59,:),Coor(33,:)]),norm([Coor(59,:),Coor(44,:)])];

Cluster1=[[1:length(I)]',J',I',len_l'];

filename='TritonCluster1_CandSet-5NN.xls'; %�洢��ѡ��·��Ϣ
xlswrite(filename,Cluster1);

G=graph(I,J);
figure;
p=plot(G,'Layout','force');

num_WTs=length(cluster1)-1;
num_OSSs=1;
p.XData=cluster1(:,2);
p.YData=cluster1(:,3);
% p.LineStyle='-.';
% labeledge(p,I,J,1:numedges(G));
p.NodeLabel=[];
p.EdgeColor='k';
p.EdgeAlpha=1;
p.LineWidth=2;
% ֮����øĳ���NodeInf��Բ
for i=1:num_WTs
    rectangle('Position',[cluster1(i,2)-0.2,cluster1(i,3)-0.2,0.4,0.4],'curvature',[1,1],'FaceColor','w','EdgeColor','k')
end
for i=1:num_OSSs
    rectangle('Position',[cluster1(num_WTs+i,2)-0.2,cluster1(num_WTs+i,3)-0.2,0.4,0.4],'FaceColor','w','EdgeColor','k')
end
axis equal % ��֤���ᣬ�������ǹ����Բ��
% д���
for l=1:length(cluster1)
    Coor1_PQ=cluster1(l,2);
    Coor2_PQ=cluster1(l,3);
    text(Coor1_PQ, Coor2_PQ, num2str(l),'HorizontalAlignment', 'center','FontSize', 9, 'Color','k','FontName', 'Times New Roman'); % printf the complex power in distribution lines(if any).
end
%ȥ�����ұ߿�̶�
box off  
%�Ƴ�������߿�
set(gca,'Visible','off');
%���ñ���Ϊ��ɫ
set(gcf,'color','w');
highlight(p,J,I,'LineStyle','--');
print(2,'-dpng','Triton_C1_5KNN');

%% Cluster2
cluster2=NodeInf(middle_nodes,:);
x=cluster2(:,2);
y=cluster2(:,3);
Coor=[x,y];
K=6; % ���������㱾��������ʵֻ����K-1�����ڵ�
[Idx,D] = knnsearch(Coor,Coor,"K",K,"Distance","euclidean");
% Idx contains the node index itself, so delete 1st column.
KNNDis=D(2:K);
figure;
gscatter(Coor(:,1),Coor(:,2));
hold on
for i=1:length(cluster2)
    number=num2str(i); % ���
    text(Coor(i,1),Coor(i,2),number);
end
hold off

Cluster2=[]; %������ѡ��·���ϣ�֮��д��xlsx
J=[]; %��ʼ�ڵ�
I=[]; %��ֹ�ڵ�
len_l=[]; %��ѡ��·����
for i=1:size(Idx,1)
    %     original_index=Idx(i,1);
    %     sort(Idx(i,:));% ��Idx������������
    for j=1:size(Idx,2)
        if Idx(i,j)>i %������ʼ�ڵ�>��ֹ�ڵ���Ž��д洢
            J=[J,Idx(i,j)];
            I=[I,i];
            len_l=[len_l,D(i,j)];
        elseif Idx(i,j)<i % ��K�����г��ֱ������ڵ����С�Ľڵ����ʱ��
            % ���֮ǰ�Ƿ��Ѿ����ֹ����洢����û�д洢�������·�ʽ���д洢
            temp=Idx(i,j);
            temp_index=find(I==temp);
            if J(temp_index)~=i
                J=[J,i];
                I=[I,Idx(i,j)];
                len_l=[len_l,D(i,j)];
            end
        end
    end
end


% J=[J,59,59,59];I=[I,31,33,44];
% len_l=[len_l,norm([Coor(59,:),Coor(31,:)]),norm([Coor(59,:),Coor(33,:)]),norm([Coor(59,:),Coor(44,:)])];

Cluster2=[[1:length(I)]',J',I',len_l'];

filename='TritonCluster2_CandSet-5NN.xls'; %�洢��ѡ��·��Ϣ
xlswrite(filename,Cluster2);

G=graph(I,J);
figure;
p=plot(G,'Layout','force');

num_OSSs=2;
num_WTs=length(cluster2)-num_OSSs;

p.XData=cluster2(:,2);
p.YData=cluster2(:,3);
% p.LineStyle='-.';
% labeledge(p,I,J,1:numedges(G));
p.NodeLabel=[];
p.EdgeColor='k';
p.EdgeAlpha=1;
p.LineWidth=2;
% ֮����øĳ���NodeInf��Բ
for i=1:num_WTs
    rectangle('Position',[cluster2(i,2)-0.2,cluster2(i,3)-0.2,0.4,0.4],'curvature',[1,1],'FaceColor','w','EdgeColor','k')
end
for i=1:num_OSSs
    rectangle('Position',[cluster2(num_WTs+i,2)-0.2,cluster2(num_WTs+i,3)-0.2,0.4,0.4],'FaceColor','w','EdgeColor','k')
end
axis equal % ��֤���ᣬ�������ǹ����Բ��
% д���
for l=1:length(cluster2)
    Coor1_PQ=cluster2(l,2);
    Coor2_PQ=cluster2(l,3);
    text(Coor1_PQ, Coor2_PQ, num2str(l),'HorizontalAlignment', 'center','FontSize', 9, 'Color','k','FontName', 'Times New Roman'); % printf the complex power in distribution lines(if any).
end
%ȥ�����ұ߿�̶�
box off  
%�Ƴ�������߿�
set(gca,'Visible','off');
%���ñ���Ϊ��ɫ
set(gcf,'color','w');
highlight(p,J,I,'LineStyle','--');
print(4,'-dpng','Triton_C2_5KNN');

%% Cluster3
cluster3=NodeInf(right_nodes,:);
x=cluster3(:,2);
y=cluster3(:,3);
Coor=[x,y];
K=6; % ���������㱾��������ʵֻ����K-1�����ڵ�
[Idx,D] = knnsearch(Coor,Coor,"K",K,"Distance","euclidean");
% Idx contains the node index itself, so delete 1st column.
KNNDis=D(2:K);
figure;
gscatter(Coor(:,1),Coor(:,2));
hold on
for i=1:length(cluster3)
    number=num2str(i); % ���
    text(Coor(i,1),Coor(i,2),number);
end
hold off

Cluster3=[]; %������ѡ��·���ϣ�֮��д��xlsx
J=[]; %��ʼ�ڵ�
I=[]; %��ֹ�ڵ�
len_l=[]; %��ѡ��·����
for i=1:size(Idx,1)
    %     original_index=Idx(i,1);
    %     sort(Idx(i,:));% ��Idx������������
    for j=1:size(Idx,2)
        if Idx(i,j)>i %������ʼ�ڵ�>��ֹ�ڵ���Ž��д洢
            J=[J,Idx(i,j)];
            I=[I,i];
            len_l=[len_l,D(i,j)];
        elseif Idx(i,j)<i % ��K�����г��ֱ������ڵ����С�Ľڵ����ʱ��
            % ���֮ǰ�Ƿ��Ѿ����ֹ����洢����û�д洢�������·�ʽ���д洢
            temp=Idx(i,j);
            temp_index=find(I==temp);
            if J(temp_index)~=i
                J=[J,i];
                I=[I,Idx(i,j)];
                len_l=[len_l,D(i,j)];
            end
        end
    end
end


% J=[J,59,59,59];I=[I,31,33,44];
% len_l=[len_l,norm([Coor(59,:),Coor(31,:)]),norm([Coor(59,:),Coor(33,:)]),norm([Coor(59,:),Coor(44,:)])];

Cluster3=[[1:length(I)]',J',I',len_l'];

filename='TritonCluster3_CandSet-5NN.xls'; %�洢��ѡ��·��Ϣ
xlswrite(filename,Cluster3);

G=graph(I,J);
figure;
p=plot(G,'Layout','force');

num_OSSs=1;
num_WTs=length(cluster3)-num_OSSs;

p.XData=cluster3(:,2);
p.YData=cluster3(:,3);
% p.LineStyle='-.';
% labeledge(p,I,J,1:numedges(G));
p.NodeLabel=[];
p.EdgeColor='k';
p.EdgeAlpha=1;
p.LineWidth=2;
% ֮����øĳ���NodeInf��Բ
for i=1:num_WTs
    rectangle('Position',[cluster3(i,2)-0.2,cluster3(i,3)-0.2,0.4,0.4],'curvature',[1,1],'FaceColor','w','EdgeColor','k')
end
for i=1:num_OSSs
    rectangle('Position',[cluster3(num_WTs+i,2)-0.2,cluster3(num_WTs+i,3)-0.2,0.4,0.4],'FaceColor','w','EdgeColor','k')
end
axis equal % ��֤���ᣬ�������ǹ����Բ��
% д���
for l=1:length(cluster3)
    Coor1_PQ=cluster3(l,2);
    Coor2_PQ=cluster3(l,3);
    text(Coor1_PQ, Coor2_PQ, num2str(l),'HorizontalAlignment', 'center','FontSize', 9, 'Color','k','FontName', 'Times New Roman'); % printf the complex power in distribution lines(if any).
end
%ȥ�����ұ߿�̶�
box off  
%�Ƴ�������߿�
set(gca,'Visible','off');
%���ñ���Ϊ��ɫ
set(gcf,'color','w');
highlight(p,J,I,'LineStyle','--');
print(6,'-dpng','Triton_C3_5KNN');