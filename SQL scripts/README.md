#DDL script:
Created tables:
•	Branch – consisting of 10  bank branches and its attributes
•	Employee – consisting of 25 employee details.
•	Customer – Consisting 50 customers records.
•	Attribute – consisting the 6 different type of transaction performed.
•	Account – details of 60 accounts current and saving for all customers.
•	Transaction_activity – consists of 250 transactions over all the accounts incluiding current, savings and credit card.
•	Debitcrd – details regarding 50 debitcards issued to the customer.
•	Creditcrd – details regarding 35 creditcards issued to the customers.

#View script:
•	customer_d: to view all the details of the customer.
•	ttt_v: to view top 3 transactions of a given customer.

#Procedures:
•	balanceupdate: updates balance in the account table when called inside the trigger when a new transaction record is inserted.
•	customer_entry: for entering a new customer record in the table, along with encrypted password.
•	employee_entry: for entering a new employee record in the table, along with encrypted password.
•	debit_entry: for entering a new debit card record in the table, along with encrypted pin.
•	detailview: displays the a particular customer detail from customer_d view along with decrypted password.

#Trigger:
•	amount: to trigger the balance update procedure as per the transaction type when a new transaction record is inserted.

#Functions:
•	encrypt: provides a computed column in an encrypted form for any varchar variable
•	decryp: provides a decrypted value for the given encrypted variable
•	ttt : returns a table with top 3 transactions for a given customer into the view ttt_v
