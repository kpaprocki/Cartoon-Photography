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

% Last Modified by GUIDE v2.5 11-May-2011 21:28:40

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
global colors;
global calc;
calc = 0;

% Set global var defaults
image = 'images/obama.jpg';
mask = 'images/obama_mask.gif';
threshHI = .68;
threshMED = .45;
threshLO = .23;
w = 6;
sigma = [3 .2];

% ------ default Obama colors 
C1_R = 'fc';
C1_G = 'e4';
C1_B = 'a8';

C2_R = '71';
C2_G = '96';
C2_B = '9f';

C3_R = 'd7';
C3_G = '1a';
C3_B = '21';

C4_R = '00';
C4_G = '32';
C4_B = '4d';

% ---- Colors ( as hex ) c1 is lightest, c4 darkest
c11 = hex2dec(C1_R)/255;
c12 = hex2dec(C1_G)/255;
c13 = hex2dec(C1_B)/255;

c21 = hex2dec(C2_R)/255;
c22 = hex2dec(C2_G)/255;
c23 = hex2dec(C2_B)/255;

c31 = hex2dec(C3_R)/255;
c32 = hex2dec(C3_G)/255;
c33 = hex2dec(C3_B)/255;

c41 = hex2dec(C4_R)/255;
c42 = hex2dec(C4_G)/255;
c43 = hex2dec(C4_B)/255;

% Light to Dark, RGB - from 0 to 255
colors(1, 1) = c11;
colors(1, 2) = c12;
colors(1, 3) = c13;
colors(2, 1) = c21;
colors(2, 2) = c22;
colors(2, 3) = c23;
colors(3, 1) = c31;
colors(3, 2) = c32;
colors(3, 3) = c33;
colors(4, 1) = c41;
colors(4, 2) = c42;
colors(4, 3) = c43;

set(handles.c_dark,'BackgroundColor', colors(4, :));
set(handles.c_meddark,'BackgroundColor', colors(3, :));
set(handles.c_medlite,'BackgroundColor', colors(2, :));
set(handles.c_lite,'BackgroundColor', colors(1, :));

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
global colors;
global calc;
global obamafied;

obamafied = obamaficator( image, mask, threshHI, threshMED, threshLO, w, sigma, colors );
calc = 1;
% select on GUI view to display
axes(handles.view);

imshow(obamafied);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global obamafied;
global calc;

if(~calc)
    errordlg('Nothing to save.','Error');
else
    [file, path, index] = uiputfile({'*.jpg',  'JPEG Image (*.jpg)';...
        '*.gif',  'GIF Image (*.gif)';...
        '*.png', 'PNG Image (*.png)'});
    
    if (ischar(file) && ischar(path))
        addpath(path);
        switch index
            case 1
                type = 'jpg';
            case 2
                type = 'gif';
            case 3
                type = 'png';
        end

        imwrite(obamafied, strcat(path, file), type);
    end
end

% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[file, path] = uigetfile({'*.jpg',  'JPEG Images (*.jpg)'}, 'Please select an input image.');
if  (ischar(file) && ischar(path))
    addpath(path);
    image = strcat(path, file);
    set(handles.image_filename,'String',file);
end



% --- Executes on button press in load_mask.
function load_mask_Callback(hObject, eventdata, handles)
% hObject    handle to load_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask;

[file, path] = uigetfile({'*.gif',  'GIF Images (*.gif)'}, 'Please select a mask.');
if (ischar(file) && ischar(path))
    addpath(path);
    mask = strcat(path, file);
    set(handles.mask_filename,'String',file);
end



function thresh_lo_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_lo as text
%        str2double(get(hObject,'String')) returns contents of thresh_lo as a double
global threshLO;

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


% --- Executes on button press in default.
function default_Callback(hObject, eventdata, handles)
% hObject    handle to default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image;
global mask;
global threshHI;
global threshMED;
global threshLO;
global w;
global sigma;
global colors;

image = 'images/obama.jpg';
mask = 'images/obama_mask.gif';
threshHI = .68;
threshMED = .45;
threshLO = .23;
w = 6;
sigma = [3 .2];

% ------ default Obama colors 
C1_R = 'fc';
C1_G = 'e4';
C1_B = 'a8';

C2_R = '71';
C2_G = '96';
C2_B = '9f';

C3_R = 'd7';
C3_G = '1a';
C3_B = '21';

C4_R = '00';
C4_G = '32';
C4_B = '4d';

% ---- Colors ( as hex ) c1 is lightest, c4 darkest
c11 = hex2dec(C1_R)/255;
c12 = hex2dec(C1_G)/255;
c13 = hex2dec(C1_B)/255;

c21 = hex2dec(C2_R)/255;
c22 = hex2dec(C2_G)/255;
c23 = hex2dec(C2_B)/255;

c31 = hex2dec(C3_R)/255;
c32 = hex2dec(C3_G)/255;
c33 = hex2dec(C3_B)/255;

c41 = hex2dec(C4_R)/255;
c42 = hex2dec(C4_G)/255;
c43 = hex2dec(C4_B)/255;

% Light to Dark, RGB - from 0 to 1
colors(1, 1) = c11;
colors(1, 2) = c12;
colors(1, 3) = c13;
colors(2, 1) = c21;
colors(2, 2) = c22;
colors(2, 3) = c23;
colors(3, 1) = c31;
colors(3, 2) = c32;
colors(3, 3) = c33;
colors(4, 1) = c41;
colors(4, 2) = c42;
colors(4, 3) = c43;

set(handles.c_dark,'BackgroundColor', colors(4, :));
set(handles.c_meddark,'BackgroundColor', colors(3, :));
set(handles.c_medlite,'BackgroundColor', colors(2, :));
set(handles.c_lite,'BackgroundColor', colors(1, :));

set(handles.image_filename,'String','obama.jpg');
set(handles.mask_filename,'String','obama_mask.gif');
set(handles.thresh_hi,'String',threshHI);
set(handles.thresh_med,'String',threshMED);
set(handles.thresh_lo,'String',threshLO);
set(handles.w,'String',w);
set(handles.s_spatial,'String',sigma(1));
set(handles.s_intensity,'String',sigma(2));


% --- Executes on button press in edit_dark.
function edit_dark_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colors;

colors(4, :) = uisetcolor('Dark');
set(handles.c_dark,'BackgroundColor', colors(4, :));


% --- Executes on button press in edit_meddark.
function edit_meddark_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meddark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colors;

colors(3, :) = uisetcolor('Medium Dark');
set(handles.c_meddark,'BackgroundColor', colors(3, :));


% --- Executes on button press in edit_medlite.
function edit_medlite_Callback(hObject, eventdata, handles)
% hObject    handle to edit_medlite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colors;

colors(2, :) = uisetcolor('Medium Lite');
set(handles.c_medlite,'BackgroundColor', colors(2, :));


% --- Executes on button press in edit_lite.
function edit_lite_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colors;

colors(1, :) = uisetcolor('Lite');
set(handles.c_lite,'BackgroundColor', colors(1, :));
