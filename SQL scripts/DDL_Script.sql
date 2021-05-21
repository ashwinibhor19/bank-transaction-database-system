create database Project_group_14;
use Project_group_14;

create table branch(branchid int IDENTITY(1,3) PRIMARY KEY, branchname varchar(25), street varchar(25), city varchar(15), sstate varchar(2), zipcode int);


create table employee(eid float PRIMARY KEY, ename varchar(25), street varchar(25), city varchar(15), sstate varchar(2), zipcode , ssn int not null, position varchar(25), salary decimal, bid int NOT NULL, managedby int, epassword varbinary(200),
CONSTRAINT fk_branchid FOREIGN KEY (bid) REFERENCES branch(branchid),
CONSTRAINT fk_managerid FOREIGN KEY (managedby) REFERENCES employee(eid));


create table customer(cid float PRIMARY KEY, cname varchar(25), street varchar(25), city varchar(15), sstate varchar(2), zipcode float, ssn float, camount float default 0, bcid int, cpassword varbinary(200) NOT NULL,
CONSTRAINT fk_cbranchid FOREIGN KEY (bcid) REFERENCES branch(branchid));


create table attribute(atid int PRIMARY KEY, attribute varchar NOT NULL);/*0-withdral, 1-depositbycash, 2-depositbycheck, 3-tranferdin, 4- transferedout, 5- creditcardtransaction*/


create table account(accnumber float PRIMARY KEY, acid float NOT NULL, abalance float, actype varchar(5),acdate datetime,
CONSTRAINT fk_customert FOREIGN KEY(acid) REFERENCES customer(cid));


create table debitcrd(cardnumber varchar(255) PRIMARY KEY, dcid float NOT NULL UNIQUE, daccnumber float NOT NULL,issue_date datetime, validity datetime,pin varbinary(200),
CONSTRAINT fk_daccnumber FOREIGN KEY(daccnumber) REFERENCES account(accnumber),
CONSTRAINT fk_dcustomer FOREIGN KEY(dcid) REFERENCES customer(cid));


create table creditcrd(ccnumber float PRIMARY KEY, ccid float NOT NULL, creditline float, totalpurchase float default 0, issue_date datetime, validity datetime,
CONSTRAINT fk_ccustomer FOREIGN KEY(ccid) REFERENCES customer(cid),
CONSTRAINT chk_credit CHECK (totalpurchase<=creditline));


create table transaction_activity(transactionId float PRIMARY KEY,taccnumber float, attid int, tamount float, timestamp datetime default GETDATE(),
CONSTRAINT fk_accnumber FOREIGN KEY(taccnumber) REFERENCES account(accnumber),
CONSTRAINT fk_ccnumber FOREIGN KEY(taccnumber) REFERENCES creditcrd(ccnumber), 
CONSTRAINT fk_attribute FOREIGN KEY (attid) REFERENCES attribute(atid),
CONSTRAINT chk_balance CHECK (tamount<=10000));