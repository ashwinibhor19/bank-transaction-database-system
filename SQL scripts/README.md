# DDL script:
### Created tables:
1. Branch – consisting of 10  bank branches and its attributes
2. Employee – consisting of 25 employee details.
3. Customer – Consisting 50 customers records.
4. Attribute – consisting the 6 different type of transaction performed.
5. Account – details of 60 accounts current and saving for all customers.
6. Transaction_activity – consists of 250 transactions over all the accounts incluiding current, savings and credit card.
7. Debitcrd – details regarding 50 debitcards issued to the customer.
8. Creditcrd – details regarding 35 creditcards issued to the customers.

# View script:
1. customer_d: to view all the details of the customer.
2. ttt_v: to view top 3 transactions of a given customer.

# Procedures:
1. balanceupdate: updates balance in the account table when called inside the trigger when a new transaction record is inserted.
2. customer_entry: for entering a new customer record in the table, along with encrypted password.
3. employee_entry: for entering a new employee record in the table, along with encrypted password.
4. debit_entry: for entering a new debit card record in the table, along with encrypted pin.
5. detailview: displays the a particular customer detail from customer_d view along with decrypted password.

# Trigger:
amount: to trigger the balance update procedure as per the transaction type when a new transaction record is inserted.

# Functions:
1. encrypt: provides a computed column in an encrypted form for any varchar variable
2. decryp: provides a decrypted value for the given encrypted variable
3. ttt : returns a table with top 3 transactions for a given customer into the view ttt_v
