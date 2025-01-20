function data = importCashFlows(workbookFile, sheetName, range)
%函数可以实现三种不同方式导入现金流数据
%DATA = IMPORTFILE(FILE)从file第一个工作表中将所有数字提取出来
%DATA = IMPORTFILE(FILE,SHEET) 从file指定工作表中将所有数据提取出来
%DATA = IMPORTFILE(FILE,SHEET,RANGE)从file指定工作表的指定范围提取数据。范围的指定使用'C1:C2'的形式，对应excel表的相应位置。
%这个函数会将所有空白格替换为数字0
 
% 不指定工作表或指定为空时，使用第一个工作表
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end
 
%如果不指定范围，使用全部数据
if nargin <= 2 || isempty(range)
    range = '';
end
 
%% 导入数据
%raw可以将表格中的每个元素以元胞数组的形式保存
%cellfun检测raw中的每个元素是否符合后继函数的要求
[~, ~, raw] = xlsread(workbookFile, sheetName, range);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
%这里的意思是，将空、非数据类型、无数据全部替换为空
 
%% 将空填充为数字0，便于直接用该矩阵进行计算
R = cellfun(@(x) isempty(x) || (ischar(x) && all(x==' ')),raw);
raw(R) = {0.0}; 
 
%% 将数据整理为需要的矩阵形式
data = reshape([raw{:}],size(raw));
