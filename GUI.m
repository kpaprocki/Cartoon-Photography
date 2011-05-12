function varargout = GUI(varargin)
% GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 11-May-2011 19:01:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w_Callback(hObject, eventdata, handles)
% hObject    handle to w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w as text
%        str2double(get(hObject,'String')) returns contents of w as a double
global w;

w = str2double(get(hObject, 'String'));
if isnan(w)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% --- Executes during object creation, after setting all properties.
function s_spatial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_spatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_spatial_Callback(hObject, eventdata, handles)
% hObject    handle to s_spatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_spatial as text
%        str2double(get(hObject,'String')) returns contents of s_spatial as a double
global sigma;

sigma(1) = str2double(get(hObject, 'String'));
if isnan(sigma(1))
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new s_spatial value
handles.metricdata.volume = volume;
guidata(hObject,handles)

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

global image
global mask;
global threshHI;
global threshMED;
global threshLO;
global w;
global sigma;

% Set global var defaults
image = 'images/obama.jpg';
mask = 'images/obama_mask.gif';
threshHI = .68;
threshMED = .48;
threshLO = .25;
w = 5;
sigma = [3 .1];

%set(handles.w, 'String', handles.metricdata.density);
%set(handles.s_spatial,  'String', handles.metricdata.volume);
%set(handles.mass, 'String', 0);

%set(handles.unitgroup, 'SelectedObject', handles.english);

%set(handles.text4, 'String', 'lb/cu.in');
%set(handles.text5, 'String', 'cu.in');
%set(handles.text6, 'String', 'lb');

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes on button press in calc.
function calc_Callback(hObject, eventdata, handles)
% hObject    handle to calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image;
global mask;
global threshHI;
global threshMED;
global threshLO;
global w;
global sigma;

global obamafied;

obamafied = obamaficator( image, mask, threshHI, threshMED, threshLO, w, sigma );

% select on GUI view to display
axes(handles.view);

imshow(obamafied);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global obamafied;


[file, path, index] = uiputfile({'*.jpg',  'JPEG Image (*.jpg)';...
    '*.gif',  'GIF Image (*.gif)';...
    '*.png', 'PNG Image (*.png)'});

switch index
    case 1
        type = 'jpg';
    case 2
        type = 'gif';
    case 3
        type = 'png';
end

imwrite(obamafied, strcat(path, file), type);

% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[file, path] = uigetfile({'*.jpg',  'JPEG Images (*.jpg)'});
image = strcat(path, file);

% --- Executes on button press in load_mask.
function load_mask_Callback(hObject, eventdata, handles)
% hObject    handle to load_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask;

[file, path] = uigetfile({'*.gif',  'GIF Images (*.gif)'});
mask = strcat(pth, file);


function thresh_lo_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_lo as text
%        str2double(get(hObject,'String')) returns contents of thresh_lo as a double
threshLO = str2double(get(hObject, 'String'));
if isnan(threshLO)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% --- Executes during object creation, after setting all properties.
function thresh_lo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresh_med_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_med as text
%        str2double(get(hObject,'String')) returns contents of thresh_med as a double
global threshMED;

threshMED = str2double(get(hObject, 'String'));
if isnan(threshMED)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% --- Executes during object creation, after setting all properties.
function thresh_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresh_hi_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_hi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_hi as text
%        str2double(get(hObject,'String')) returns contents of thresh_hi as a double
global threshHI

threshHI = str2double(get(hObject, 'String'));
if isnan(threshHI)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% --- Executes during object creation, after setting all properties.
function thresh_hi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_hi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to s_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_intensity as text
%        str2double(get(hObject,'String')) returns contents of s_intensity as a double
global sigma;

sigma(2) = str2double(get(hObject, 'String'));
if isnan(sigma(2))
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% --- Executes during object creation, after setting all properties.
function s_intensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
