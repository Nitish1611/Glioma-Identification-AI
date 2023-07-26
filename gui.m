function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 18-May-2022 16:52:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ... 
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

a=ones([256 256]);
axes(handles.axes1);
imshow(a);

axes(handles.axes2);
imshow(a);

axes(handles.axes3);
imshow(a);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global train 
matlabpath ='C:\Users\NITISH\Documents\Glioma\glioma'
data = fullfile(matlabpath,'dataset')

train = imageDatastore(data, 'IncludeSubfolders',true,'LabelSource','foldernames');
count = train.countEachLabel;

msgbox('Dataset Loaded Successfully')

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global layers
disp('Pre-Trained Model Loaded...')
net = resnet50;

layers = [ imageInputLayer([256 256 1])
    
net(2:end-3)

fullyConnectedLayer(2)

softmaxLayer

classificationLayer()

]
msgbox('Pre-Trained Model Loaded Successfully')

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%training
global train 
matlabpath ='C:\Users\NITISH\Documents\Glioma\glioma'
data = fullfile(matlabpath,'dataset')

train = imageDatastore(data, 'IncludeSubfolders',true,'LabelSource','foldernames');
train = augmentedImageDatastore([256 256 1],train,'ColorPreprocessing', 'rgb2gray');

global opt training train layers
opt = trainingOptions('adam','Maxepoch',32,'InitialLearnRate', 0.001)

training = trainNetwork(train,layers,opt);

msgbox('Trained Completed')

% Update handles structure
guidata(hObject, handles);

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inp
cd input
[file path] = uigetfile('*.bmp;*.png;*.jpg','Pick an Image File');


if isequal(file,0)
       warndlg('File not selected');
else

inp = imread(file);
cd ..
axes(handles.axes1);
imshow(inp);

[r c p] = size(inp);

if p==3
    hsv = rgb2hsv(inp);
else 
    inp = inp;
end


axes(handles.axes5);
imshow(hsv);
title('RGB to HSV Image');

h = hsv(:,:,1);
s = hsv(:,:,2);
v = hsv(:,:,3);

figure;
subplot(1,3,1);imshow(h,[]);title('hue plane')
subplot(1,3,2);imshow(s,[]);title('Saturation plane')
subplot(1,3,3);imshow(v,[]);title('Intensity value plane');
 
    


end
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inp J
img = im2gray(inp);
img = imresize(img,[256 256])
J = medfilt2(img);
axes(handles.axes2);
title('Filtered Image');
imshow(J);




Lp=double(uint8(img));
[rows,columns] = size(Lp);
lop_img = zeros(size(Lp));
 

for row = 2 : rows - 1   
    for col = 2 : columns - 1    
        centerPixel = Lp(row, col);
        pixel7=Lp(row-1, col-1) > centerPixel;  %%-1-1  225deg
        pixel6=Lp(row-1, col) > centerPixel;    %%-10   180deg
        pixel5=Lp(row-1, col+1) > centerPixel;  %%-11   135deg
        pixel4=Lp(row, col+1) > centerPixel;    %%01    90deg
        pixel3=Lp(row+1, col+1) > centerPixel;  %%11    45deg
        pixel2=Lp(row+1, col) > centerPixel;    %%10    0deg  
        pixel1=Lp(row+1, col-1) > centerPixel;  %%1-1   315deg 
        pixel0=Lp(row, col-1) > centerPixel;    %% 0-1  270deg   
        lop_img(row, col) = uint8( pixel7 * 2^7 + pixel6 * 2^6 + pixel5 * 2^5 + pixel4 * 2^4 +pixel3 * 2^3 + pixel2 * 2^2 + pixel1 * 2 + pixel0);
    end  
end 


axes(handles.axes4);
imshow(lop_img,[]);
title('LBP Image')

handles.lop_img = lop_img;
% Update handles structure
guidata(hObject, handles);
% --- Executes on button press in pushbutton4.


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global training inp out J
out = classify(training,J);
axes(handles.axes3);
imshow(inp);
title(string(out));
% Update handles structure
guidata(hObject, handles);
if (string(out)=="non defected")
                
  msgbox(string(out));
else
            
  msgbox(string(out));
  [segout] = MSegment(J); 
  boundary = bwboundaries(im2bw(segout));
     
end



           


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%update handles structure
guidata(hObject,handles);
