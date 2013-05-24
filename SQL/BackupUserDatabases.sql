USE [Tools]
GO
/****** Object:  StoredProcedure [dbo].[BackupUserDatabases]    Script Date: 03/15/2007 07:55:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BackupUserDatabases]
(
	@backupType VARCHAR(15)
)
AS

DECLARE @backupFolder VARCHAR(255)

SET @backupFolder = 'C:\NotBackedUp\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\' + @backupType

DECLARE @timestamp DATETIME
DECLARE @dateString VARCHAR(8)
DECLARE @timeString VARCHAR(12)

SELECT @timestamp = GETDATE()

SELECT @dateString = CONVERT(VARCHAR(8), @timestamp, 112)

SELECT @timeString = CONVERT(VARCHAR(12), @timestamp, 14)

-- Remove seconds from timestamp
SET @timeString = LEFT(REPLACE(@timeString,':',''), 4)

DECLARE @databases TABLE
(
	ID INT IDENTITY ( 1, 1 )
	, DatabaseName SYSNAME
)

INSERT INTO
	@databases 
	SELECT name
	FROM master.dbo.sysdatabases 
	WHERE name NOT IN ( 'master', 'model', 'msdb', 'tempdb' )

DECLARE @id TINYINT
SELECT @id = MIN ( ID ) FROM @databases

WHILE @id IS NOT NULL BEGIN
	DECLARE @databaseName SYSNAME
	SELECT @databaseName = DatabaseName FROM @databases WHERE ID = @id

	DECLARE @backupFileName VARCHAR(512)
	SELECT @backupFileName = @databaseName + '_backup_' +@dateString + @timeString + '.bak'

	IF @backupType = 'Full'
	BEGIN
		EXEC ('BACKUP DATABASE [' + @databaseName + '] TO DISK =''' + @backupFolder + '\' + @BackupFileName + '''')
	END
	ELSE IF @backupType = 'Differential'
	BEGIN
		EXEC ('BACKUP DATABASE [' + @databaseName + '] TO DISK =''' + @backupFolder + '\' + @BackupFileName + ''' WITH DIFFERENTIAL')
	END
	ELSE IF @backupType = 'Transaction Log'
	BEGIN
		DECLARE @recoveryModel SQL_VARIANT

		SELECT @recoveryModel = DATABASEPROPERTYEX(@databaseName, 'Recovery')

		IF @recoveryModel <> 'SIMPLE'
		BEGIN
			EXEC ('BACKUP LOG [' + @databaseName + '] TO DISK =''' + @backupFolder + '\' + @BackupFileName + '''')
		END
	END
	ELSE
	BEGIN
		RAISERROR ('Invalid backup type', 16, 1)
	END

	DELETE FROM @databases WHERE ID = @id

	SELECT @id = MIN ( ID ) FROM @databases
END

