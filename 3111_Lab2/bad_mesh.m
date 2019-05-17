% This script is written and read by pdetool and should NOT be edited.
% There are two recommended alternatives:
 % 1) Export the required variables from pdetool and create a MATLAB script
 %    to perform operations on these.
 % 2) Define the problem completely using a MATLAB script. See
 %    http://www.mathworks.com/help/pde/examples/index.html for examples
 %    of this approach.
function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[766.40000000000009 825.75 127.73333333333335]);
set(ax,'XLim',[0 20]);
set(ax,'YLimMode','auto');
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');
pdetool('gridon','on');

% Geometry description:
pderect([6.5 8.5 4 2],'R1');
pdeellip(12.25,4.25,0.75,0.75,...
0,'E1');
pdeellip(12.25,1.75,0.75,0.75,...
0,'E2');
pderect([0 20 6 0],'R2');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R2-R1-E1-E2')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(16,...
'neu',...
1,...
'0',...
'0')
pdesetbd(15,...
'neu',...
1,...
'0',...
'0')
pdesetbd(14,...
'neu',...
1,...
'0',...
'0')
pdesetbd(13,...
'neu',...
1,...
'0',...
'0')
pdesetbd(12,...
'neu',...
1,...
'0',...
'0')
pdesetbd(11,...
'neu',...
1,...
'0',...
'0')
pdesetbd(10,...
'neu',...
1,...
'0',...
'0')
pdesetbd(9,...
'neu',...
1,...
'0',...
'0')
pdesetbd(8,...
'neu',...
1,...
'0',...
'0')
pdesetbd(7,...
'neu',...
1,...
'0',...
'-25')
pdesetbd(6,...
'neu',...
1,...
'0',...
'0')
pdesetbd(5,...
'neu',...
1,...
'0',...
'0')
pdesetbd(4,...
'neu',...
1,...
'0',...
'0')
pdesetbd(3,...
'dir',...
1,...
'1',...
'0')
pdesetbd(2,...
'neu',...
1,...
'0',...
'0')
pdesetbd(1,...
'neu',...
1,...
'0',...
'0')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')
pdetool('jiggle')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'0',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0';...
'0.0';...
'0  ';...
'1.0'])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[4 1 1 1 3 1 10 1 0 0 0 1 1 1 0 1 0 1]);
setappdata(pde_fig,'colstring','(1*10^6) + 0.5*1*(25^2) - 0.5*1*(sqrt(ux.^2 + uy.^2)).^2');
setappdata(pde_fig,'arrowstring','[ux;uy]');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')
