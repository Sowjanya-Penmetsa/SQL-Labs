create table Clients(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL)

CREATE TABLE AccountTypes(
Id INT PRIMARY KEY IDENTITY,
[NAME] NVARCHAR(50) NOT NULL)

CREATE TABLE Accounts (
	Id INT PRIMARY KEY IDENTITY,
	AccountTypeId INT FOREIGN KEY REFERENCES AccountTypes(Id),
	Balance DECIMAL(15, 2) NOT NULL DEFAULT(0),
	ClientId INT FOREIGN KEY REFERENCES Clients(Id)
)

INSERT INTO Clients(FirstName,LastName)VALUES
('greta', 'Andersson'),
('Peter', 'Pettersson'),
('Mel', 'Gibson'),
('Maria', 'Danielsson')

INSERT INTO AccountTypes (Name) VALUES
('Checking'),
('Savings')

INSERT INTO Accounts(ClientId, AccountTypeId, Balance) VALUES
(1, 1, 175),
(2, 1, 275.56),
(3, 1, 138.01),
(4, 1, 40.30),
(4, 2, 375.50)

-------------------- View for dispalying the owner, type and balance of each account in database-------------

CREATE VIEW v_ClientBalances AS
SELECT(FirstName+' '+LastName)AS [Name],AccountTypes.NAME as [Account Type],Balance
FROM Accounts
Join Clients on Clients.Id=Accounts.ClientId
Join AccountTypes on AccountTypes.Id=Accounts.AccountTypeId

select * from Accounts

------------------function creation which calculates the total balance from all accounts of a single client----------------

create FUNCTION f_CalculateTotalBalance 
(
	-- Add the parameters for the function here
	@ClientID INT
)
RETURNS DECIMAL(15, 2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Decimal(15,2)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = Sum(Balance) from Accounts where ClientId=@ClientID

	-- Return the result of the function
	RETURN @Result

END

select dbo.f_CalculateTotalBalance(4) AS Balance


-------- -----------------Procedure to create a new account for existing customer--------------

CREATE PROCEDURE p_AddAccount
	-- Add the parameters for the stored procedure here
	@ClientId INT, @AccountTypeId INT 	
AS
BEGIN
    -- Insert statements for procedure here
	INSERT INTO Accounts (ClientId, AccountTypeId) VALUES (@ClientId, @AccountTypeId)
END
GO

select * from Accounts;

p_AddAccount 2,2;

select * from Accounts;

-----------------------------Deposit Procedure----------------------------

CREATE PROCEDURE p_Deposit 
-- Add the parameters for the stored procedure here
@AccountId INT, @Amount DECIMAL(15, 2) 
AS
BEGIN
-- Insert statements for procedure here---
UPDATE Accounts
SET Balance += @Amount
WHERE Id = @AccountId
END
GO

p_Deposit 2,100;

select * from Accounts;

p_Deposit 4,100;

---------------- Withdraw Procedure------------------

create procedure p_Withdraw
-- Add the parameters for the stored procedure here----
@AccountId INT, @Amount DECIMAL(15, 2) 
AS
BEGIN
-- Insert statements for procedure here---
	DECLARE @OldBalance DECIMAL(15, 2)
	SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
	IF (@OldBalance - @Amount >= 0)
	BEGIN
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountId
	END
	ELSE
	BEGIN
		RAISERROR('Insufficient funds')
	END
END


p_Withdraw 2,100;

select * from Accounts;

p_Withdraw 1,175;

------------------------------------------------------------------------------
-----Our bank will need a way to record transactions done by its clients, so we are now going to create a new table and a trigger, which will automatically record the date, time and amount transferred into the table.
CREATE TABLE Transactions (
	Id INT PRIMARY KEY IDENTITY,
	AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
	OldBalance DECIMAL(15, 2) NOT NULL,
	NewBalance DECIMAL(15, 2) NOT NULL,
	Amount AS NewBalance - OldBalance,
	[DateTime] DATETIME2
)

-----------Trigger Creation-----------
CREATE TRIGGER tr_Transaction ON Accounts
AFTER UPDATE
AS
	INSERT INTO Transactions (AccountId, OldBalance, NewBalance, [DateTime])
	SELECT inserted.Id, deleted.Balance, inserted.Balance, GETDATE() FROM inserted
	JOIN deleted ON inserted.Id = deleted.Id



p_Deposit 1, 25.00
GO

p_Deposit 1, 40.00
GO

p_Withdraw 2, 200.00
GO

p_Deposit 4, 180.00
GO

select * from Transactions;


