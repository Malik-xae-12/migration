

SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') AS AuthMode;




CREATE LOGIN migration_user
WITH PASSWORD = 'Migration@123456';
GO

USE MigrationTestDB;
GO

CREATE USER migration_user
FOR LOGIN migration_user;
GO

ALTER ROLE db_datareader
ADD MEMBER migration_user;
GO

ALTER ROLE db_datawriter
ADD MEMBER migration_user;
GO


SELECT
    dp.name AS UserName,
    dp.type_desc
FROM sys.database_principals dp
WHERE dp.name = 'migration_user';

