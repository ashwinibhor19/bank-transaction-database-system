use Project_group_14;
create procedure balanceupdate @acid float, @balance float
AS
declare @temp_cid float,@cbu float,@abu float
select @abu=abalance,@temp_cid=acid from account where accnumber=@acid;
select @cbu=camount from customer where cid=@temp_cid;
select @temp_cid=acid from account where accnumber=@acid;
UPDATE account set abalance=@abu+@balance;
UPDATE customer set camount=@cbu+@balance;
GO 

create function encrypt(@password varchar(25))
returns varbinary(200)
AS
BEGIN
	declare @ep varbinary(200)
	set @ep=Encryptbypassphrase('project_group-14',@password)
	return @ep
END

create function decryp(@password varbinary(200))
returns varchar(25)
AS
BEGIN
	declare @dp varchar(25)
	set @dp=convert(varchar(25),Decryptbypassphrase('project_group-14',@password))
	return @dp
END


create procedure customer_entry @cid float, @cname varchar(25), @street varchar(25), @city varchar(15), @state varchar(2), @zipcode float, @ssn float, @bcid float, @password varchar(25)
AS
if (@ssn=null)
Begin
insert into customer (cid, cname, street, city, sstate,zipcode,bcid, cpassword) 
values(@cid, @cname, @street, @city, @state, @zipcode, @bcid, dbo.encrypt(@password));
end
else
begin
	insert into customer (cid, cname, street, city, sstate,zipcode,cpassword,ssn, bcid) 
	values(@cid, @cname, @street, @city, @state, @zipcode, dbo.encrypt(@password),@ssn,@bcid);
end
GO

create procedure employee_entry @eid float, @ename varchar(25), @street varchar(25), @city varchar(15), @state varchar(2), @zipcode float, @password varchar(25), @ssn float, @position varchar(25), @salary float, @bid float, @mby float
AS
	insert into employee (ename, street, city, sstate,zipcode, ssn, position, salary, bid, managedby, epassword) 
	values(@ename, @street, @city, @state, @zipcode, @ssn, @position, @salary, @bid, @mby, dbo.encrypt(@password));
GO

create procedure debit_entry @cardnumber float, @dcid float, @daccnumber float, @issue_date datetime, @validity datetime, @pin varchar(25) 
AS
	insert into debitcrd(cardnumber, dcid, daccnumber, issue_date, validity, pin) 
	values(@cardnumber,@dcid,@daccnumber,@issue_date,@validity,dbo.encrypt(@pin));
GO



create procedure detailview @cid float
AS
	--insert into customer_d select * from customer;
	select cid,cname,street,city,sstate,zipcode,dbo.decryp(cpassword) as password,ssn,camount,bid from customer_d c where c.cid=@cid;
GO

create function ttt (@cid float)
returns table
return
	select top 3 acid, (attid) AS transactiontype, amount, timestamp 
	from (select a.acid as acid, t.attid as attid, t.tamount as amount, t.timestamp as timestamp 
	from account a join transaction_activity t on a.accnumber=t.taccnumber where a.acid=@cid) as ttt
	order by timestamp

create trigger amount on transaction_activity
AFTER insert
AS
BEGIN
declare @atid int,@tacn float, @tam float
select @atid=attid,@tacn=taccnumber,@tam=tamount from inserted;
if (@atid=5)
BEGIN
	declare @ttp decimal
	select @ttp=totalpurchase from creditcrd where ccnumber=@tacn
	UPDATE creditcrd set totalpurchase=@ttp+@tam 
	where ccnumber=@tacn
END
ELSE
BEGIN
	declare @balance float;
	if (@atid=0)
	BEGIN
		set @balance=@tam*-1;
	END
	else if (@atid=1)
	BEGIN
		set @balance=@tam;
	END
	else if (@atid=2)
	BEGIN
		set @balance=@tam;
	END
	else if (@atid=3)
	BEGIN
		set @balance=@tam;
	END
	else
	BEGIN
		set @balance=@tam*-1;
	END
	EXEC balanceupdate @tacn, @balance;
END
END