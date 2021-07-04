function varargout = ImageEnchanmentUAS(varargin)
% IMAGEENCHANMENTUAS MATLAB code for ImageEnchanmentUAS.fig
%      IMAGEENCHANMENTUAS, by itself, creates a new IMAGEENCHANMENTUAS or raises the existing
%      singleton*.
%
%      H = IMAGEENCHANMENTUAS returns the handle to a new IMAGEENCHANMENTUAS or the handle to
%      the existing singleton*.
%
%      IMAGEENCHANMENTUAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEENCHANMENTUAS.M with the given input arguments.
%
%      IMAGEENCHANMENTUAS('Property','Value',...) creates a new IMAGEENCHANMENTUAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageEnchanmentUAS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageEnchanmentUAS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageEnchanmentUAS

% Last Modified by GUIDE v2.5 04-Jul-2021 23:53:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageEnchanmentUAS_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageEnchanmentUAS_OutputFcn, ...
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


% --- Executes just before ImageEnchanmentUAS is made visible.
function ImageEnchanmentUAS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageEnchanmentUAS (see VARARGIN)

% Choose default command line output for ImageEnchanmentUAS
%handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT mak es ImageEnchanmentUAS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageEnchanmentUAS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnProses.
function btnProses_Callback(hObject, eventdata, handles)
global processing;
global result;
if isequal(processing, 'grayscale')
    image = handles.data1;
    res = rgb2gray(image);
    result = res;
    axes(handles.output);
    imshow(res);
    handles.data2 = res;
    guidata(hObject, handles);
elseif isequal(processing, 'negative')
    image = handles.data1;
    res = 255 - image;
    result = res;
    axes(handles.output);
    imshow(res);
    handles.data2 = res;
    guidata(hObject, handles);
elseif isequal(processing, 'original')
    image = handles.data1;
    res = image;
    result = res;
    axes(handles.output);
    imshow(res);
    handles.data2 = res;
    guidata(hObject, handles);
else 
    image = handles.data1;
    res = im2bw(image, 0.6);
    result = res;
    axes(handles.output);
    imshow(res);
    handles.data2 = res;
    guidata(hObject, handles);
end
% hObject    handle to btnProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnloadimg.
function btnloadimg_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.*'},'Select file');

if ~isequal(filename, 0)
    handles.data1 = imread(fullfile(pathname, filename));
    guidata(hObject, handles);
    axes(handles.input);
    imshow(handles.data1);
else 
    return
end
% hObject    handle to btnloadimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
    
    val = get(hObject, 'value');
    x  = abs(val);
    disp(x);
    image = handles.data1;
    if isequal(val, 0)
        res = image;
    elseif val > 1
        res = image + val;
    else 
        res = image - abs(val);
    end
    axes(handles.output);
    imshow(res);
    handles.data2 = res;
    guidata(hObject, handles);
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
    set(handles.slider1, 'SliderStep', [1/501, 10/501]);
end

% hObject    handle to rdBiner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rdBiner.
function rdBiner_Callback(hObject, eventdata, handles)
global processing;
processing = 'biner'
% hObject    handle to rdBiner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdBiner


% --- Executes on button press in rdGrayscale.
function rdGrayscale_Callback(hObject, eventdata, handles)
global processing;
processing = 'grayscale';
% hObject    handle to rdGrayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdGrayscale


% --- Executes on button press in rdNegative.
function rdNegative_Callback(hObject, eventdata, handles)
global processing;
processing = 'negative';
% hObject    handle to rdNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdNegative


% --- Executes on button press in rdEq.
function rdEq_Callback(hObject, eventdata, handles)
global processing;
processing = 'eq';
% hObject    handle to rdEq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdEq


% --- Executes on button press in rdOri.
function rdOri_Callback(hObject, eventdata, handles)
global processing;
processing = 'original';
% hObject    handle to rdOri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdOri


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    global result;
    startingFolder = userpath
    defaultFileName = fullfile(startingFolder, '*.png*');
    [baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
    if baseFileName == 0
      % User clicked the Cancel button.
      return;
    end
    fullFileName = fullfile(folder, baseFileName)
    imwrite(result, fullFileName);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
