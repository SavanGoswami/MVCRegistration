USE [HotelDB]
GO
/****** Object:  UserDefinedFunction [dbo].[NvarcharToIntList]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    Create FUNCTION [dbo].[NvarcharToIntList] (@InStr VARCHAR(MAX))
    RETURNS @TempTab TABLE
       (id int not null)
    AS
    BEGIN
        ;-- Ensure input ends with comma
        SET @InStr = REPLACE(@InStr + ',', ',,', ',')
        DECLARE @SP INT
    DECLARE @VALUE VARCHAR(1000)
    WHILE PATINDEX('%,%', @INSTR ) <> 0 
    BEGIN
       SELECT  @SP = PATINDEX('%,%',@INSTR)
       SELECT  @VALUE = LEFT(@INSTR , @SP - 1)
       SELECT  @INSTR = STUFF(@INSTR, 1, @SP, '')
       INSERT INTO @TempTab(id) VALUES (@VALUE)
    END
        RETURN
    END
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](20) NULL,
	[FunctionName] [varchar](150) NULL,
	[InputData] [varchar](500) NULL,
	[OutputData] [varchar](500) NULL,
	[UserId] [int] NULL,
	[GroupType] [varchar](100) NULL,
	[FullErrorDescription] [varchar](max) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCity]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCity](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](50) NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_tblCity] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCountry]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCountry](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NULL,
 CONSTRAINT [PK_tblCountry] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHobby]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHobby](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](20) NOT NULL,
 CONSTRAINT [PK_tblHobby] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Phone] [varchar](10) NULL,
	[EmailId] [varchar](100) NULL,
	[CountryId] [int] NULL,
	[CityId] [int] NULL,
	[Gender] [varchar](6) NULL,
	[PhotoUrl] [varchar](500) NULL,
	[Hobbies] [varchar](50) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ErrorLog] ON 

INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (1, N'Error', N'DeleteUser', N'client_id: 25', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 123', CAST(N'2018-06-12T06:53:22.230' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (2, N'Error', N'AddEditUser', N'client_id: 26', N'An error occurred while updating the entries. See the inner exception for details.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.Entity.Core.UpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_tblUser_tblCountry". The conflict occurred in database "HotelDB", table "dbo.tblCountry", column ''CountryId''.
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.<NonQuery>b__0(DbCommand t, DbCommandInterceptionContext`1 c)
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Internal.InterceptableDbCommand.ExecuteNonQuery()
   at System.Data.Entity.Core.Mapping.Update.Internal.DynamicUpdateCommand.Execute(Dictionary`2 identifierValues, List`1 generatedValues)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 42', CAST(N'2018-06-13T06:04:19.533' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (3, N'Error', N'AddEditUser', N'client_id: 26', N'An error occurred while updating the entries. See the inner exception for details.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.Entity.Core.UpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_tblUser_tblCountry". The conflict occurred in database "HotelDB", table "dbo.tblCountry", column ''CountryId''.
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.<NonQuery>b__0(DbCommand t, DbCommandInterceptionContext`1 c)
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Internal.InterceptableDbCommand.ExecuteNonQuery()
   at System.Data.Entity.Core.Mapping.Update.Internal.DynamicUpdateCommand.Execute(Dictionary`2 identifierValues, List`1 generatedValues)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 42', CAST(N'2018-06-13T06:04:19.533' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (4, N'Error', N'AddEditUser', N'client_id: 18', N'Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions. ---> System.Data.Entity.Core.OptimisticConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.ValidateRowsAffected(Int64 rowsAffected, UpdateCommand source)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 42', CAST(N'2018-06-13T08:07:58.240' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (5, N'Error', N'AddEditUser', N'client_id: 22', N'Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions. ---> System.Data.Entity.Core.OptimisticConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.ValidateRowsAffected(Int64 rowsAffected, UpdateCommand source)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 42', CAST(N'2018-06-13T08:19:16.977' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (6, N'Error', N'AddEditUser', N'client_id: 22', N'Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions. ---> System.Data.Entity.Core.OptimisticConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.ValidateRowsAffected(Int64 rowsAffected, UpdateCommand source)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 42', CAST(N'2018-06-13T11:03:15.470' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (7, N'Error', N'DeleteUser', N'client_id: 28', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:22:52.590' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (8, N'Error', N'DeleteUser', N'client_id: 26', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:24:30.590' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (9, N'Error', N'DeleteUser', N'client_id: 32', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:32:23.447' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (10, N'Error', N'DeleteUser', N'client_id: 32', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:32:31.243' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (11, N'Error', N'DeleteUser', N'client_id: 33', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:34:16.817' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (12, N'Error', N'DeleteUser', N'client_id: 34', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:36:01.993' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (13, N'Error', N'DeleteUser', N'client_id: 34', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:36:40.173' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (14, N'Error', N'DeleteUser', N'client_id: 38', N'Value cannot be null.
Parameter name: entity', 0, N'UserService', N'System.ArgumentNullException: Value cannot be null.
Parameter name: entity
   at System.Data.Entity.Utilities.Check.NotNull[T](T value, String parameterName)
   at System.Data.Entity.DbSet`1.Remove(TEntity entity)
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Delete(Int32 Id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 83
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.DeleteUser(Int32 id) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 129', CAST(N'2018-06-14T06:50:36.880' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (15, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__1(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T10:39:26.350' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (16, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__1(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T10:40:05.297' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (17, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__1(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T10:40:28.647' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (18, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__1(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T11:00:35.137' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (19, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__0(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T11:01:47.350' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (20, N'Error', N'GetUserList', N'', N'Object reference not set to an instance of an object.', 0, N'UserService', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.<>c__DisplayClass1_0.<GetUserList>b__0(User x) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66
   at System.Collections.Generic.List`1.ConvertAll[TOutput](Converter`2 converter)
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.GetUserList() in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 66', CAST(N'2018-06-14T11:04:11.727' AS DateTime))
INSERT [dbo].[ErrorLog] ([Id], [Type], [FunctionName], [InputData], [OutputData], [UserId], [GroupType], [FullErrorDescription], [CreatedOn]) VALUES (21, N'Error', N'AddEditUser', N'client_id: 1040', N'Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.', 0, N'UserService', N'System.Data.Entity.Infrastructure.DbUpdateConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions. ---> System.Data.Entity.Core.OptimisticConcurrencyException: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. See http://go.microsoft.com/fwlink/?LinkId=472540 for information on understanding and handling optimistic concurrency exceptions.
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.ValidateRowsAffected(Int64 rowsAffected, UpdateCommand source)
   at System.Data.Entity.Core.Mapping.Update.Internal.UpdateTranslator.Update()
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.<Update>b__2(UpdateTranslator ut)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update[T](T noChangesResult, Func`2 updateFunction)
   at System.Data.Entity.Core.EntityClient.Internal.EntityAdapter.Update()
   at System.Data.Entity.Core.Objects.ObjectContext.<SaveChangesToStore>b__35()
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesToStore(SaveOptions options, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass2a.<SaveChangesInternal>b__27()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChangesInternal(SaveOptions options, Boolean executeInExistingTransaction)
   at System.Data.Entity.Core.Objects.ObjectContext.SaveChanges(SaveOptions options)
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   --- End of inner exception stack trace ---
   at System.Data.Entity.Internal.InternalContext.SaveChanges()
   at System.Data.Entity.Internal.LazyInternalContext.SaveChanges()
   at System.Data.Entity.DbContext.SaveChanges()
   at MVCRegistration.BusinessAccess.Generic.GenericUnit`1.Update(TEntity entityToUpdate) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Generic\GenericUnit.cs:line 47
   at MVCRegistration.BusinessAccess.Factory.Service.UserService.AddEditUser(UserModel model) in D:\Demo\MVCRegistration\MVCRegistration.BusinessAccess\Factory\Service\UserService.cs:line 43', CAST(N'2018-06-18T04:50:57.113' AS DateTime))
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
SET IDENTITY_INSERT [dbo].[tblCity] ON 

INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (2, N'Mumbai', 1)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (3, N'Delhi', 1)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (4, N'Chennai', 1)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (6, N'New York', 2)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (8, N'Los Angeles', 2)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (9, N'Chicago', 2)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (10, N'Bejing', 3)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (12, N'Wuhan', 3)
INSERT [dbo].[tblCity] ([CityId], [CityName], [CountryId]) VALUES (14, N'Dalian', 3)
SET IDENTITY_INSERT [dbo].[tblCity] OFF
SET IDENTITY_INSERT [dbo].[tblCountry] ON 

INSERT [dbo].[tblCountry] ([CountryId], [CountryName]) VALUES (1, N'India')
INSERT [dbo].[tblCountry] ([CountryId], [CountryName]) VALUES (2, N'USA')
INSERT [dbo].[tblCountry] ([CountryId], [CountryName]) VALUES (3, N'China')
SET IDENTITY_INSERT [dbo].[tblCountry] OFF
SET IDENTITY_INSERT [dbo].[tblHobby] ON 

INSERT [dbo].[tblHobby] ([ID], [Name]) VALUES (1, N'Cricket             ')
INSERT [dbo].[tblHobby] ([ID], [Name]) VALUES (2, N'Football            ')
INSERT [dbo].[tblHobby] ([ID], [Name]) VALUES (3, N'Chess               ')
INSERT [dbo].[tblHobby] ([ID], [Name]) VALUES (4, N'Reading             ')
INSERT [dbo].[tblHobby] ([ID], [Name]) VALUES (5, N'Painting            ')
SET IDENTITY_INSERT [dbo].[tblHobby] OFF
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (41, N'Blossom', N'Macaulay', N'4924147520', N'egestas.urna@luctusfelis.net', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (52, N'Luke', N'Aristotle', N'9992640360', N'at.fringilla@Suspendissedui.edu', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (53, N'Maxine', N'Christine', N'3165014630', N'eleifend@eget.org', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (54, N'Graiden', N'Zia', N'9641623900', N'enim@lobortisquam.edu', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (55, N'Lucy', N'Maite', N'0825715870', N'mattis@sitamet.com', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (56, N'Callie', N'Shad', N'5578752660', N'eu@Aliquameratvolutpat.co.uk', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (57, N'Callum', N'Craig', N'0873292530', N'sodales.at.velit@aliquam.co.uk', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (58, N'Cooper', N'Grant', N'8504142640', N'at.lacus@turpisegestas.ca', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (59, N'Elvis', N'Tyler', N'6545978760', N'enim.sit.amet@orci.co.uk', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (60, N'Norman', N'Amethyst', N'9424128170', N'sed.dolor.Fusce@diamdictumsapien.edu', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (61, N'Risa', N'Wang', N'3535794120', N'aliquam.eros@vehicula.co.uk', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (62, N'Steven', N'Amery', N'5929924110', N'lectus@pede.ca', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (63, N'Bevis', N'Claudia', N'5239604040', N'Phasellus@faucibusorciluctus.co.uk', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (64, N'Plato', N'Shoshana', N'0218632510', N'mattis@duiFuscealiquam.edu', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (65, N'Colette', N'Patrick', N'1530378990', N'ornare@vitaerisusDuis.net', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (66, N'Sydnee', N'Zenia', N'2744740350', N'ipsum@ipsumCurabiturconsequat.net', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (68, N'Kristen', N'Tanner', N'2584466400', N'mauris@porttitorerosnec.org', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (69, N'Indigo', N'Jenna', N'3627849980', N'luctus@massaSuspendisseeleifend.com', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (71, N'Hermione', N'Karleigh', N'8271332830', N'nunc@ullamcorper.ca', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (72, N'Chanda', N'Tatyana', N'4114351990', N'mi@posuerecubiliaCurae.co.uk', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (73, N'Avye', N'Elvis', N'4698016990', N'tempus.scelerisque@mauriserat.org', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (74, N'Mannix', N'Rebekah', N'2785518080', N'nunc.Quisque@Cras.net', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (75, N'Montana', N'Ian', N'7635062920', N'Aenean.massa@vitaemaurissit.org', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (76, N'Chelsea', N'Sasha', N'4842370140', N'vitae.sodales.nisi@sempererat.edu', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (78, N'Luke', N'Derek', N'3248097960', N'Aenean.gravida.nunc@eu.net', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (79, N'Penelope', N'Kessie', N'1835346360', N'ac@senectuset.com', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (80, N'Sage', N'Macon', N'5663002040', N'erat.Sed.nunc@elitafeugiat.org', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (81, N'Isabelle', N'Tasha', N'3325475260', N'Nunc.mauris@sed.co.uk', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (83, N'Alvin', N'Rebecca', N'6864905440', N'ac.libero@vitae.co.uk', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (85, N'Colorado', N'Seth', N'5586242430', N'massa.non.ante@quisturpis.ca', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (86, N'Darryl', N'Kennan', N'5443406670', N'mus@non.com', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (89, N'Joy', N'Owen', N'9196945050', N'arcu.Vestibulum@leoinlobortis.org', 1, 2, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (91, N'Brynn', N'Halla', N'6166694740', N'dui.Fusce.aliquam@tempus.co.uk', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (94, N'Kai', N'Cairo', N'9580691510', N'amet.dapibus.id@lectus.edu', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (95, N'Cynthia', N'Ruby', N'2999975060', N'libero.Morbi@adipiscingelit.edu', 1, 3, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (96, N'Kimberley', N'Wyatt', N'3328891900', N'molestie.tellus@tortorInteger.edu', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (97, N'Ezekiel', N'Melyssa', N'6684793910', N'facilisis.vitae@liberoettristique.net', 1, 4, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (98, N'Debra', N'Hiroko', N'2214805790', N'aliquam.eros.turpis@magnaCrasconvallis.ca', 1, 2, N'Male', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (101, N'Richard', N'Roth', N'3916258300', N'consectetuer@ligula.com', 1, 3, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (102, N'Indira', N'Christopher', N'8792114540', N'mus@massa.co.uk', 1, 4, N'Female', NULL, N'1,2')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (103, N'Isadora', N'Ori', N'7867592540', N'molestie.in@non.com', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (104, N'Haley', N'Kai', N'6921554820', N'rutrum@idmollisnec.net', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (106, N'Kelsie', N'Azalia', N'9826463770', N'Quisque.nonummy@ategestas.com', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (107, N'Akeem', N'Rae', N'4029901120', N'Sed.nulla.ante@in.ca', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (108, N'Xena', N'Chandler', N'6430341160', N'laoreet@sapien.co.uk', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (109, N'Seth', N'Yoshi', N'3736167250', N'mollis.non@tellusSuspendisse.ca', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (110, N'Oliver', N'Alika', N'4623708130', N'erat.volutpat.Nulla@Aliquameratvolutpat.org', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (111, N'Beau', N'Wyoming', N'5284191970', N'sem.Pellentesque@quisdiamPellentesque.edu', 1, 3, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (112, N'Mari', N'Jacqueline', N'1521851350', N'erat.in@penatibus.ca', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (113, N'Ifeoma', N'Germaine', N'4745845870', N'rutrum@Donecfeugiat.co.uk', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (114, N'Jayme', N'Ray', N'2765758430', N'nulla@magnamalesuadavel.org', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (115, N'Stacy', N'Blaze', N'8233691650', N'dolor.dolor.tempus@pretiumaliquetmetus.co.uk', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (116, N'Noah', N'Ruby', N'7826854070', N'at@sem.edu', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (117, N'Nero', N'Miriam', N'5757290140', N'tellus@Aliquam.ca', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (118, N'Pamela', N'Quincy', N'2146703530', N'pretium.aliquet@Morbi.com', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (119, N'Harlan', N'Marah', N'8403465050', N'sagittis@ridiculusmusProin.edu', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (120, N'Wang', N'Vaughan', N'8751069340', N'mattis.Cras@consectetueripsum.edu', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (121, N'Ciaran', N'Imani', N'9315496150', N'malesuada.ut.sem@tellusAenean.ca', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (122, N'Kasimir', N'Perry', N'1317628140', N'Nunc.ullamcorper.velit@quis.net', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (124, N'Haviva', N'Vincent', N'5280611670', N'commodo@loremauctorquis.com', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (125, N'Mona', N'Amaya', N'2649667680', N'auctor.ullamcorper.nisl@ametmetusAliquam.org', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (126, N'Carla', N'Signe', N'4584505450', N'quis.accumsan.convallis@ipsumprimis.ca', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (127, N'Denton', N'Kiara', N'9139938070', N'sociis.natoque@sapienmolestieorci.ca', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (128, N'Jesse', N'Kane', N'1876389810', N'ac.nulla@nunc.edu', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (129, N'David', N'Paloma', N'3372160700', N'neque.Sed.eget@nulla.net', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (130, N'Zachary', N'Giacomo', N'3605220100', N'gravida.molestie@Integer.edu', 1, 4, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (131, N'Odette', N'Iliana', N'9835131620', N'lorem.ipsum@arcuVestibulumante.ca', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (132, N'Lunea', N'Hiram', N'7169910670', N'eget.odio@ridiculus.co.uk', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (133, N'Honorato', N'Brock', N'1572526030', N'Quisque.fringilla@ametorciUt.co.uk', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (134, N'Herman', N'Cody', N'2995240090', N'dui.Cum.sociis@sitamet.edu', 1, 3, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (135, N'Rosalyn', N'Lacey', N'3792396060', N'cursus.a@Maurisvel.org', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (137, N'Declan', N'Driscoll', N'2872504240', N'amet@mattissemper.org', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (138, N'Jarrod', N'Adena', N'8288762310', N'id.magna@Inscelerisquescelerisque.com', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (139, N'Adara', N'Fay', N'8375396620', N'purus.Duis@posuereenim.edu', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (140, N'Savannah', N'May', N'2272180100', N'Integer.aliquam.adipiscing@porttitortellusnon.net', 1, 3, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (141, N'Susan', N'Quinn', N'5810874860', N'Mauris.vel.turpis@loremacrisus.com', 1, 4, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (142, N'Sarah', N'Morgan', N'8132407290', N'Fusce.fermentum.fermentum@orci.co.uk', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (143, N'Lillith', N'Clayton', N'9074425040', N'magna.tellus.faucibus@etlacinia.net', 1, 3, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (144, N'Walter', N'Lavinia', N'3748919680', N'arcu.Sed@enimgravidasit.edu', 1, 2, N'Female', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (146, N'Emma', N'Hanae', N'0731821440', N'arcu@lorem.net', 1, 2, N'Male', NULL, N'1,3,5')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (147, N'Dalton', N'Ruby', N'5525358550', N'mauris.sit.amet@lacus.edu', 1, 4, N'Male', NULL, N'1,2,3')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (148, N'Elton', N'Shay', N'9218485000', N'Fusce.mollis@duisemperet.ca', 1, 4, N'Male', NULL, N'1,2,3')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (149, N'Amelia', N'Chaim', N'8391360880', N'amet@molestieSed.net', 1, 2, N'Female', NULL, N'1,2,3')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (150, N'Sasha', N'Mary', N'7495475080', N'nibh.Phasellus.nulla@ametante.edu', 1, 2, N'Female', NULL, N'1,2,3')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (151, N'Hammett', N'Aristotle', N'3165942910', N'lobortis@arcu.com', 1, 2, N'Female', NULL, N'1,2,3')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (1760, N'Lawrence', N'Nolan', N'0989046150', N'mauris.rhoncus.id@pedeNunc.ca', 1, 4, N'Male', N'~\UploadFile\download - Copy (2).png', N'1')
INSERT [dbo].[tblUser] ([Id], [Firstname], [Lastname], [Phone], [EmailId], [CountryId], [CityId], [Gender], [PhotoUrl], [Hobbies]) VALUES (1761, N's', N's', N'12', N'sas@gmai;.cpm', 1, 4, N'male', N'', N'1,2')
SET IDENTITY_INSERT [dbo].[tblUser] OFF
ALTER TABLE [dbo].[tblCity]  WITH CHECK ADD  CONSTRAINT [FK_tblCity_tblCountry] FOREIGN KEY([CountryId])
REFERENCES [dbo].[tblCountry] ([CountryId])
GO
ALTER TABLE [dbo].[tblCity] CHECK CONSTRAINT [FK_tblCity_tblCountry]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblCity] FOREIGN KEY([CityId])
REFERENCES [dbo].[tblCity] ([CityId])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblCity]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblCountry] FOREIGN KEY([CountryId])
REFERENCES [dbo].[tblCountry] ([CountryId])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblCountry]
GO
/****** Object:  StoredProcedure [dbo].[GetHobbyList]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Savan,,Name>
-- Create date: <11/06/2018,,>
-- Description:	<Getting hobby list,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetHobbyList]
	@UserId int 
AS
BEGIN
	SET NOCOUNT ON;
    declare @param varchar(max)
	declare @CSV varchar(max) = ''
	Select @param=Hobbies from tblUser where ID =@UserId
	SELECT @CSV = COALESCE(@CSV + ',', '') + RTRIM(hby.Name) from tblHobby hby where ID in (SELECT id FROM dbo.NvarcharToIntList(@param))
	select STUFF(@CSV,1,1,'') 
END

GO
/****** Object:  StoredProcedure [dbo].[GetHobbyListByIDForEdit]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Savan,,Name>
-- Create date: <11/06/2018,,>
-- Description:	<Getting hobby list,,>
-- =============================================
Create PROCEDURE [dbo].[GetHobbyListByIDForEdit]
	@UserId int 
AS
BEGIN
	SET NOCOUNT ON;
    declare @param varchar(max)
Select @param=Hobbies from tblUser where ID =@UserId
SELECT * , CAST(
             CASE 
                  WHEN ID in (SELECT id FROM dbo.NvarcharToIntList(@param)) 
                     THEN 1 
                  ELSE 0 
             END AS bit) as isSelected 
FROM tblHobby
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserList]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserList] 
AS
BEGIN
	SET NOCOUNT ON;
	Select * , (Select CountryName from tblCountry where CountryId = usr.CountryId) as CountryName ,
(Select CityName from tblCity where CityId = usr.CityId) as CityName from tblUser usr
END

GO
/****** Object:  StoredProcedure [dbo].[LogErrorOccured]    Script Date: 26-06-2018 11:52:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 07 FEB 2017
-- Description:	To log details about the exception/error occurred.
-- =============================================
CREATE PROCEDURE [dbo].[LogErrorOccured]
	@Type VARCHAR(20),
	@FunctionName VARCHAR(150),
	@InputData VARCHAR(500),
	@OutputData VARCHAR(500),	
	@UserID INT, 
	@GroupType VARCHAR(100), 
	@FullErrorDescription NVARCHAR(MAX)	
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO ErrorLog ([Type], FunctionName, InputData, OutputData,  UserID, CreatedOn, GroupType, FullErrorDescription)
    VALUES (@Type, @FunctionName, @InputData, @OutputData, @UserID, GETUTCDATE(), @GroupType, @FullErrorDescription);
END
GO
