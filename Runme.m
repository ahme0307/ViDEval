warning('off');
prompt = {'Name:', 'Email:'};
dlg_title = 'Observer Details';
num_lines = 1;
global NAME;
global EMAIL;
defaultans = {'Fred','fred@gmail.com'};
answer = inputdlg(prompt,dlg_title, num_lines,defaultans);
O_Folder = './Original';
TSR_Folder = './TSR';
NAME = answer{1}; EMAIL = answer{2};
TSR_Eval(O_Folder,TSR_Folder)