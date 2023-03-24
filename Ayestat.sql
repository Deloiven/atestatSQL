-- Транзакции. Временные таблицы, управляющие конструкции, циклы
CREATE PROCEDURE [dbo].[usp_CreateUser]
@Login NVARCHAR(50), -- Логин пользователя
@Password NVARCHAR(50), -- Пароль пользователя
@IsAdmin BIT, -- признак прав администратора
@IsUser BIT -- признак прав простого пользователя
AS
BEGIN
        DECLARE @SQL NVARCHAR(2000) 
        SET @SQL = ' CREATE LOGIN ' + QUOTENAME(@Login) + ' WITH PASSWORD = ' + QUOTENAME(@Password, '''') + ', CHECK_POLICY = OFF ' 
                         +  ' CREATE USER ' + QUOTENAME(@Login) + ' FOR LOGIN ' + QUOTENAME(@Login)  
                         +  ' IF ' + CONVERT(nvarchar(1),@IsAdmin) + ' = 1  BEGIN EXEC sp_addrolemember "db_owner" ,' + @Login + ' END ' -- если есть права админа  назначаем роль db_owner
                         + '  IF ' + CONVERT(nvarchar(1),@IsUser) + ' = 1 BEGIN EXEC sp_addrolemember "db_datawriter" ,' + @Login  -- если есть права пользователя назначаем роль db_datawriter
                         + ' EXEC sp_addrolemember "db_datareader" ,' + @Login +' END ' -- если есть права пользователя назначаем роль db_datareader
                         + ' IF  (select count (Us.Login) from Users AS Us WHERE Us.Login = '+@Login+') = 0 ' 
                         + ' BEGIN
                              INSERT INTO Users(Login,IsAdmin,IsUser) VALUES ('+@Login +','+ CONVERT(nvarchar(1),@IsAdmin)+','+ CONVERT(nvarchar(1),@IsUser)+')' -- вносим в таблицу users логин (поле Login) и булевые значения прав администратора (поле IsAdmin) и пользователя (поле IsUser)
                         + ' END'
        EXECUTE (@SQL)
END
