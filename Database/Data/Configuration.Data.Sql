IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].[Configuration])
BEGIN
 INSERT INTO [dbo].[Configuration] (ConfigurationId, Name, Value) VALUES
	(1, 'BaseUrl', 'https://www.balldontlie.io/api/v1/')
END
GO