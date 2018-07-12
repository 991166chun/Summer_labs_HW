function varargout = lab10p1(varargin)
% LAB10P1 MATLAB code for lab10p1.fig
%      LAB10P1, by itself, creates a new LAB10P1 or raises the existing
%      singleton*.
%
%      H = LAB10P1 returns the handle to a new LAB10P1 or the handle to
%      the existing singleton*.
%
%      LAB10P1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB10P1.M with the given input arguments.
%
%      LAB10P1('Property','Value',...) creates a new LAB10P1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab10p1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab10p1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab10p1

% Last Modified by GUIDE v2.5 11-Jul-2018 08:01:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab10p1_OpeningFcn, ...
                   'gui_OutputFcn',  @lab10p1_OutputFcn, ...
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



% --- Executes just before lab10p1 is made visible.
function lab10p1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab10p1 (see VARARGIN)

% Choose default command line output for lab10p1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab10p1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab10p1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File_Name, Path_Name] = uigetfile('*.png', 'Select Image');
    I = imread([Path_Name,File_Name]);   
    axes(handles.axes1);
    imshow(I);
    title('Image')
bw = imbinarize(I);
J = imclose( bw, strel('disk',1,8));
J = imopen( J, strel('disk',1,8));
handles.img = J;
guidata(hObject, handles);
handles.Rimg = J;
guidata(hObject, handles);
L = bwlabel(J,4);
num = max(max(L));
area = zeros(num,1);
for k = 1:num
    [r,c] = find(L == k);
    area(k) = length(r);
end
handles.num = num;
guidata(hObject, handles);
handles.area = area;
guidata(hObject, handles);
        axes(handles.axes2);
        histogram(area)
        title('Grain size histogram')
set(handles.text4,'string',num2str(num));
set(handles.text6,'string',num2str(mean(area)));

        
        


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spsize = get(handles.edit1,'string')
sp = str2double(spsize);
J = handles.img;
K = bwareaopen(J, sp);
        axes(handles.axes3);
        imshow(K);
        title('Result image')
handles.Rimg = K;
guidata(hObject, handles);        
L = bwlabel(K,4);
num = max(max(L));
area = zeros(num,1);
for k = 1:num
    [r,c] = find(L == k);
    area(k) = length(r);
end
handles.num = num;
guidata(hObject, handles);
handles.area = area;
guidata(hObject, handles);
        axes(handles.axes2);
        histogram(area)
        title('Grain size histogram')
set(handles.text4,'string',num2str(num));
set(handles.text6,'string',num2str(mean(area)));


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = get(handles.checkbox1,'value');
M = handles.Rimg;
num = handles.num;
area = handles.area;
if i == 1
    N = bwmorph(M,'thin',1);
    J = imclose( N, strel('disk',2,8));
    N = imopen( J, strel('disk',2,8));
    L = bwlabel(N,4);
    num2 = max(max(L));
    avgar = sum(area)/num;
    axes(handles.axes3);
        imshow(N);
        title('Result image')
    set(handles.text4,'string',num2str(num2));
    set(handles.text6,'string',num2str(avgar));    
else
    axes(handles.axes3);
        imshow(M);
        title('Result image')
    set(handles.text4,'string',num2str(num));
    set(handles.text6,'string',num2str(mean(area))); 
end

% Hint: get(hObject,'Value') returns toggle state of checkbox1
