function save_data(hObject, eventdata, handles)
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global vid1_score;
global vid2_score;
global NAME;
global EMAIL;
Prev = readtable('Data.txt', 'Delimiter',' ','ReadVariableNames',true);
T1{1}=O_Folder;
T1{2}=filelist_orig(order(status-1)).name;
T1{3}=side(status-1);
T1{4}=order(status-1);
format shortg
currTime = clock;
currTime = sprintf('%.0f.' , currTime);
currTime = currTime(1:end-1);
if side(status-1)==0
    T1{5} ='First';
    T1{6} =vid1_score;
else
    T1{5}='Second';
    T1{6} =vid2_score;
end
%score here;
T1{7} =NAME;
T1{8} =EMAIL;
T1{9} =currTime;
T2{1}=TSR_Folder;
T2{2}=file_list_tsr(order(status-1)).name;
T2{3}=side(status-1);
T2{4}=order(status-1);
if side(status-1)==1
    T2{5}='First';
    T2{6} =vid1_score;
else
    T2{5}='Second';
    T2{6} =vid2_score;
end
T2{7} =NAME;
T2{8} =EMAIL;
T2{9} =currTime;
headers = {'Folder','Video','Coin','randlist','Score','Appear','Clock','Name','Email'};
T = [T1; T2];
res=cell2table(T);
res.Properties.VariableNames = headers;
if (size(Prev,1)==0)
    MERGERESULT=res;
else
    MERGERESULT=[Prev;res];
end

writetable(MERGERESULT,'Data.txt','Delimiter',' ')
end