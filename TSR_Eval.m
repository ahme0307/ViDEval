function varargout = TSR_Eval(varargin)
% TSR_EVAL MATLAB code for TSR_Eval.fig
%      TSR_EVAL, by itself, creates a new TSR_EVAL or raises the existing
%      singleton*.
%
%      H = TSR_EVAL returns the handle to a new TSR_EVAL or the handle to
%      the existing singleton*.
%
%      TSR_EVAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TSR_EVAL.M with the given input arguments.
%
%      TSR_EVAL('Property','Value',...) creates a new TSR_EVAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TSR_Eval_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TSR_Eval_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TSR_Eval

% Last Modified by GUIDE v2.5 10-Sep-2017 16:51:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TSR_Eval_OpeningFcn, ...
                   'gui_OutputFcn',  @TSR_Eval_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TSR_Eval is made visible.
function TSR_Eval_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TSR_Eval (see VARARGIN)

% Choose default command line output for TSR_Eval
handles.output = hObject;
video_Hgt= 580;
% Update handles structure
guidata(hObject, handles);

Pix_SS = get(0,'screensize');
xo=(Pix_SS(3)-580)/2; yo=(Pix_SS(4)-580)/2;
set(handles.Player, 'Position', [xo,yo,video_Hgt,video_Hgt]);
set(hObject, 'units','normalized','outerposition',[0 0 1 1]);
set(hObject, 'color', [0.5, 0.5, 0.5])
im0=imread('./Icons/im0.png');
dispaly_images(handles.Player,im0)
configure_env(handles)

% UIWAIT makes TSR_Eval wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global vid_count;
status=1;
O_Folder=varargin{1};
TSR_Folder=varargin{2};
cd(O_Folder);
filelist_orig=dir('*avi');
cd ..
cd(TSR_Folder);
file_list_tsr=dir('*avi');
cd ..
[M,~] = size(file_list_tsr);
vid_count=M;
order = randperm(M)';
side =round(rand(M,1));

% --- Outputs from this function are returned to the command line.
function varargout = TSR_Eval_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(hObject, 'units','normalized','outerposition',[0 0 1 1]);
set(hObject, 'color', [0.5, 0.5, 0.5]);
configure_env(handles)


%set(
function dispaly_images(handles_path,im1)
% first image

[w,h,~]=size(im1);
pos=getpixelposition(handles_path);
x0shift=(pos(3)-w)/2;
y0shift=(pos(4)-h)/2;
axes(handles_path);
imshow(im1);
set(handles_path,'position', [pos(1)+x0shift,pos(2)+y0shift  w h]) 
truesize;


% --- Executes on button press in butn_start.
function butn_start_Callback(hObject, eventdata, handles)
% hObject    handle to butn_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global vid_count;
global voted 

voted =0;
set(handles.butn_start, 'visible','off');
set(handles.push_back, 'visible','on');
set(handles.push_play, 'visible','on');
set(handles.push_next, 'visible','on');
set(handles.text_status, 'visible','on');
set(handles.push_next, 'Enable','off');
set(handles.push_back, 'Enable','off');
 set(handles.text_status, 'String',[num2str(status),'/',num2str(vid_count)]);



if side((status))==1
    input_video_file = [TSR_Folder,'/',file_list_tsr(order(status)).name];
else
    input_video_file = [O_Folder,'/',filelist_orig(order(status)).name];
end
 %####

% Acquiring video
videoObject = VideoReader(input_video_file);
% Display first frame
frame_1 = read(videoObject,1);
dispaly_images(handles.Player,frame_1)
function configure_env(handles)

Pix_SS = get(0,'screensize');
xo=(Pix_SS(3)-580)/2; yo=(Pix_SS(4)-580)/2;
set(handles.push_back, 'Position', [xo+210,yo-50,50,50]);
set(handles.push_play, 'Position', [xo+285,yo-50,50,50]);
set(handles.push_replay, 'Position', [xo+285,yo-50,50,50]);
set(handles.push_next, 'Position', [xo+360,yo-50,50,50]);
set(handles.butn_start, 'Position', [xo+280,yo-50,100,20]);
set(handles.text_status, 'Position', [Pix_SS(3)-300,100,100,100]);
set(handles.video_tag, 'Position', [xo+210,yo+600,100,50]);
set(handles.push_back, 'visible','off');
set(handles.push_play, 'visible','off');
set(handles.push_next, 'visible','off');
set(handles.push_replay, 'visible','off');
set(handles.text_status, 'visible','off');
set(handles.video_tag, 'visible','off');
set(handles.uipanel1,'visible','off');
set(handles.uipanel1,'Position', [xo+50,yo+150,500,200]);





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_back.
function push_back_Callback(hObject, eventdata, handles)
% hObject    handle to push_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global input_video_file;
global voted 
set(handles.uipanel1,'visible','off');
if voted==1
    if side((status))==1
        input_video_file = [TSR_Folder,'/',file_list_tsr(order(status)).name];
    else
        input_video_file = [O_Folder,'/',filelist_orig(order(status)).name];
    end
    % Acquiring video
    set(handles.video_tag, 'visible','on');
    set(handles.video_tag, 'String','Video 1')
    videoObject = VideoReader(input_video_file); 
    play_video(handles,videoObject)
    voted=voted-1;
elseif voted==2
    set(handles.push_replay, 'visible','on');
    if side((status))==0
        input_video_file = [TSR_Folder,'/',file_list_tsr(order(status)).name];
    else
        input_video_file = [O_Folder,'/',filelist_orig(order(status)).name];
    end
     %####
    set(handles.video_tag, 'visible','on');
    set(handles.video_tag, 'String','Video 2')
    videoObject = VideoReader(input_video_file);
    play_video(handles,videoObject)
    voted=voted-1;
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over push_back.
function push_back_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to push_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_play.
function push_play_Callback(hObject, eventdata, handles)
% hObject    handle to push_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global input_video_file;
global voted 

voted =0;
if side((status))==1
    input_video_file = [TSR_Folder,'/',file_list_tsr(order(status)).name];
else
    input_video_file = [O_Folder,'/',filelist_orig(order(status)).name];
end
% Acquiring video
set(handles.video_tag, 'visible','on');
set(handles.video_tag, 'String','Video 1')
videoObject = VideoReader(input_video_file);
play_video(handles,videoObject)

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over push_play.
function push_play_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to push_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_next.
function push_next_Callback(hObject, eventdata, handles)
% hObject    handle to push_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global O_Folder;
global TSR_Folder;
global filelist_orig;
global file_list_tsr;
global status;
global order;
global side;
global input_video_file;
global voted 
voted =voted+1;
if voted==1
    if side((status))==0
        input_video_file = [TSR_Folder,'/',file_list_tsr(order(status)).name];
    else
        input_video_file = [O_Folder,'/',filelist_orig(order(status)).name];
    end
     %####
    set(handles.video_tag, 'visible','on');
    set(handles.video_tag, 'String','Video 2')
    videoObject = VideoReader(input_video_file);
    play_video(handles,videoObject)
elseif voted==2
    set(handles.video_tag, 'visible','off');
    set(handles.push_replay, 'visible','off');
    set(handles.Player,'visible','off');
    set(handles.push_next, 'Enable','off');
    cla(handles.Player);
    set(handles.uipanel1,'visible','on');
    
end
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over push_next.
function push_next_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to push_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_replay.
function push_replay_Callback(hObject, eventdata, handles)
% hObject    handle to push_replay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global input_video_file;

videoObject = VideoReader(input_video_file);
play_video(handles,videoObject)
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over push_replay.
function push_replay_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to push_replay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function play_video(handles,videoObject)

set(handles.push_back, 'Enable','off');
set(handles.push_play, 'Enable','off');
set(handles.push_next, 'Enable','off');
set(handles.push_replay, 'Enable','off');
[~,name1,~] = fileparts(videoObject.path);
% set(handles.text_status, 'String',[name1,'\',videoObject.Name])
axes(handles.Player);
for frameCount = 1:videoObject.NumberOfFrames
    % Display frames
    frame = read(videoObject,frameCount);
    imshow(frame);
    drawnow;
end
set(handles.push_play, 'visible','off');
set(handles.push_replay, 'visible','on');
set(handles.push_back, 'Enable','on');
set(handles.push_play, 'Enable','on');
set(handles.push_next, 'Enable','on');
set(handles.push_replay, 'Enable','on');


% --- Executes on button press in push_star1.
function push_star1_Callback(hObject, eventdata, handles)
% hObject    handle to push_star1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1_score;

temp=get(handles.push_star1, 'BackgroundColor');
if sum(temp==[0 1 0])
    clear_push1(hObject, eventdata, handles)
    vid1_score=0;
else
    set(handles.push_star1, 'BackgroundColor','green');
    vid1_score=1;
end
% --- Executes on button press in push_star2.
function push_star2_Callback(hObject, eventdata, handles)
% hObject    handle to push_star2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=get(handles.push_star2, 'BackgroundColor');
global vid1_score;
if sum(temp==[0 1 0])
    clear_push1(hObject, eventdata, handles)
    vid1_score=0;
else
    set(handles.push_star2, 'BackgroundColor','green');
    set(handles.push_star1, 'BackgroundColor','green');
    vid1_score=2;
end
% --- Executes on button press in push_star3.
function push_star3_Callback(hObject, eventdata, handles)
% hObject    handle to push_star3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1_score;
temp=get(handles.push_star3, 'BackgroundColor');
if sum(temp==[0 1 0])
    clear_push1(hObject, eventdata, handles)
    vid1_score=0;
else
    set(handles.push_star3, 'BackgroundColor','green');
    set(handles.push_star2, 'BackgroundColor','green');
    set(handles.push_star1, 'BackgroundColor','green');
    vid1_score=3;
end
% --- Executes on button press in push_star4.
function push_star4_Callback(hObject, eventdata, handles)
% hObject    handle to push_star4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1_score;
temp=get(handles.push_star4, 'BackgroundColor');
if sum(temp==[0 1 0])
  clear_push1(hObject, eventdata, handles)
  vid1_score=0;
else
    set(handles.push_star4, 'BackgroundColor','green');
    set(handles.push_star3, 'BackgroundColor','green');
    set(handles.push_star2, 'BackgroundColor','green');
    set(handles.push_star1, 'BackgroundColor','green');
    vid1_score=4;
end
% --- Executes on button press in push_star5.
function push_star5_Callback(hObject, eventdata, handles)
% hObject    handle to push_star5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid1_score;
temp=get(handles.push_star5, 'BackgroundColor');
if sum(temp==[0 1 0])
    clear_push1(hObject, eventdata, handles)
    vid1_score=0;
else
    set(handles.push_star5, 'BackgroundColor','green');
    set(handles.push_star4, 'BackgroundColor','green');
    set(handles.push_star3, 'BackgroundColor','green');
    set(handles.push_star2, 'BackgroundColor','green');
    set(handles.push_star1, 'BackgroundColor','green');
    vid1_score=5;
end
% --- Executes on button press in push2_star1.
function push2_star1_Callback(hObject, eventdata, handles)
% hObject    handle to push2_star1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid2_score;
temp=get(handles.push2_star1, 'BackgroundColor');
if sum(temp==[0 1 0])
    clear_push2(hObject, eventdata, handles)
    vid2_score=0;
else
    set(handles.push2_star1, 'BackgroundColor','green');
    vid2_score=1;
end

% --- Executes on button press in push2_star2.
function push2_star2_Callback(hObject, eventdata, handles)
% hObject    handle to push2_star2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid2_score;
temp=get(handles.push2_star2, 'BackgroundColor');
if sum(temp==[0 1 0])
    vid2_score=0;
    clear_push2(hObject, eventdata, handles)
else
    set(handles.push2_star2, 'BackgroundColor','green');
    set(handles.push2_star1, 'BackgroundColor','green');
     vid2_score=2;
end

% --- Executes on button press in push2_star3.
function push2_star3_Callback(hObject, eventdata, handles)
% hObject    handle to push2_star3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid2_score;
temp=get(handles.push2_star3, 'BackgroundColor');
if sum(temp==[0 1 0])
    vid2_score=0;
    clear_push2(hObject, eventdata, handles)
else
    set(handles.push2_star3, 'BackgroundColor','green');
    set(handles.push2_star2, 'BackgroundColor','green');
    set(handles.push2_star1, 'BackgroundColor','green');
    vid2_score=3;
end

% --- Executes on button press in push2_star4.
function push2_star4_Callback(hObject, eventdata, handles)
% hObject    handle to push2_star4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid2_score;
temp=get(handles.push2_star4, 'BackgroundColor');
if sum(temp==[0 1 0])
    vid2_score=0;
    clear_push2(hObject, eventdata, handles) 
else
    set(handles.push2_star4, 'BackgroundColor','green');
    set(handles.push2_star3, 'BackgroundColor','green');
    set(handles.push2_star2, 'BackgroundColor','green');
    set(handles.push2_star1, 'BackgroundColor','green');
    vid2_score=4;
end

% --- Executes on button press in push2_star5.
function push2_star5_Callback(hObject, eventdata, handles)
% hObject    handle to push2_star5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid2_score;
temp=get(handles.push2_star5, 'BackgroundColor');
if sum(temp==[0 1 0])
    vid2_score=0;
    clear_push2(hObject, eventdata, handles)
else
    set(handles.push2_star5, 'BackgroundColor','green');
    set(handles.push2_star4, 'BackgroundColor','green');
    set(handles.push2_star3, 'BackgroundColor','green');
    set(handles.push2_star2, 'BackgroundColor','green');
    set(handles.push2_star1, 'BackgroundColor','green');
    vid2_score=5;
end

% --- Executes on button press in push_submit.
function push_submit_Callback(hObject, eventdata, handles)
% hObject    handle to push_submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global status;
global vid_count;
global vid1_score;
global vid2_score;
status=status+1;
if vid_count<status
    Message='Completed';
    save_data(hObject, eventdata, handles);
    msgbox(Message)
    close(handles.figure1)
    return;
else
    set(handles.uipanel1,'visible','off');
    clear_push2(hObject, eventdata, handles)
    clear_push1(hObject, eventdata, handles)
    set(handles.push_back, 'Enable','off');
    save_data(hObject, eventdata, handles);
    vid1_score=0;
    vid2_score =0;
    butn_start_Callback(hObject, eventdata, handles)
end
function clear_push2(hObject, eventdata, handles)
    set(handles.push2_star5, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push2_star4, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push2_star3, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push2_star2, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push2_star1, 'BackgroundColor',[0.9400    0.9400    0.9400]);
function clear_push1(hObject, eventdata, handles)
    set(handles.push_star1, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push_star2, 'BackgroundColor',[0.9400    0.9400    0.9400]);  
    set(handles.push_star3, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push_star4, 'BackgroundColor',[0.9400    0.9400    0.9400]);
    set(handles.push_star5, 'BackgroundColor',[0.9400    0.9400    0.9400]); 
