function BondPrices = importBondPrices(workbookFile,sheetName,startRow,endRow)
%函数可以实现对三种不同输入方式的债券价格的提取
% BondPrices = IMPORTFILE(FILE)从file的第一个工作表提取全部价格
% BondPrices = IMPORTFILE(FILE,SHEET) 从file指定工作表提取全部价格
% BondPrices = IMPORTFILE(FILE,SHEET,STARTROW,ENDROW) 从file指定工作表的指定位置提取价格。其中startrow和endrow可以是一对标量或者一对维数对应的向量 

%不指定sheet或sheet为空时，阅读第一个sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end
 
%不指定startrow和endrow时，设置默认的行数（从2到6）
if nargin <= 3
    startRow = 2;
    endRow = 6;
end
 
%%导入数据
%sprintf可以实现将%d替换为后面的数字
data = xlsread(workbookFile, sheetName, sprintf('A%d:A%d',startRow(1),endRow(1)));
%实现startrow和endrow是向量的情况
for block=2:length(startRow)
tmpDataBlock=xlsread(workbookFile,sheetName,sprintf('A%d:A%d',startRow(block),endRow(block)));
    data = [data;tmpDataBlock];
end
 
%% 债券价格是数据的第一列
BondPrices = data(:,1);
