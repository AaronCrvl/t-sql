--01. padrão /  default
-- check if field already exists / validar se o campo já existe
IF(SELECT COUNT(*) FROM sys.columns WHERE OBJECT_ID('Client')=OBJECT_ID AND NAME='CLIENT_CATEGORY_ID')=0 
    ALTER TABLE Client ADD CLIENT_CATEGORY_ID INT

--02. coluna com valor padrõa / column with default value
-- check if field already exists / validar se o campo já existe
IF(SELECT COUNT(*) FROM sys.columns WHERE OBJECT_ID('Client')=OBJECT_ID AND NAME='CLIENT_CATEGORY_ID')=0
    ALTER TABLE Client ADD CLIENT_CATEGORY_ID INT not null default(25) -- categoria alteatória / random default category

--03. coluna com referencia a outra tabela / column with other table refference
-- check if field already exists / validar se o campo já existe
IF(SELECT COUNT(*) FROM sys.columns WHERE OBJECT_ID('Client')=OBJECT_ID AND NAME='CLIENT_CATEGORY_ID')=0
    ALTER TABLE Client ADD CLIENT_CATEGORY_ID INT not null default(25) REFERENCES Category(CATEGORY_ID)