# Financial_assistant
Financial assistant is used to calculate the expenses, income and budget and map the expenses automatically to budget. This support multiple user support.This uses JSP,servlet and Tomcat app server.


### Functionality:

**Signup** : Every family is provided with a security key. This security is an auto generated random hexadecimal number.During sign up  of the first user in the family, with user Email-ID and password will get a security key. And this can be shared with other family members, so that the users sharing the same security key will be able to share the data.

**Add,edit and update Income expenses and budget** : All the members of the family can add,edit and update the income,budget,expenses.All the members of their family can see the data of their family.

**Graphs** : Four graphs are provided .1. Income in every month of the present year, 2.Expenses in every month of the present year, 3.Income and expenses Vs every month of the present year and 4.Expenses Vs Budget.

**Total savings** : The system will calculate the total savings in every month and calculate total savings for the current year of the family.

**Expenses Vs Budget** : While logging expenses against the budget planned, the system will calculate how much is spent in the budget and plot a expenses vs budget graph and make a progress bar for the visual representation.

**Password encryption** : All the passwords stored in the user table are encrypted with md5() function is MySql.

### Dependencies
javax.servlet-api-3.0.1.jar

jsp-api-2.2.jar

mysql-connector-java-8.0.20.jar

servlet-api-2.5.jar

### MySql database schema

#### user table
| Field        | Type         | Null | key | Default | Extra          |
|--------------|--------------|------|-----|---------|----------------|
| user_id      | int          | NO   | PRI | NULL    | auto_increment |
| email        | varchar(255) | NO   |     | NULL    |                |
|  password    | varchar(255) | NO   |     | NULL    |                |
| security_key | varchar(255) | NO   |     | NULL    |                |

#### income table
| Field            | Type         | Null | key | Default | Extra          |
|------------------|--------------|------|-----|---------|----------------|
| income_id        | int          | NO   | PRI | NULL    | auto_increment |
| income_name      | varchar(255) | NO   |     | NULL    |                |
| transaction_date | date         | NO   |     | NULL    |                |
| amount           |  double      | NO   |     | NULL    |                |
| security_key     | varchar(255) | NO   |     | NULL    |                |

#### expenses table
| Field            | Type         | Null | key | Default | Extra          |
|------------------|--------------|------|-----|---------|----------------|
| expenses_id        | int          | NO   | PRI | NULL    | auto_increment |
| expenses_name      | varchar(255) | NO   |     | NULL    |                |
| transaction_date | date         | NO   |     | NULL    |                |
| amount           |  double      | NO   |     | NULL    |                |
| security_key     | varchar(255) | NO   |     | NULL    |                |

#### budget table
| Field         | Type         | Null | key | Default | Extra          |
|---------------|--------------|------|-----|---------|----------------|
| budget_id     | int          | NO   | PRI | NULL    | auto_increment |
| budget_name   | varchar(255) | NO   |     | NULL    |                |
| starting_date | date         | NO   |     | NULL    |                |
| ending_date   | date         | NO   |     | NULL    |                |
| amount        | double       | NO   |     | NULL    |                |
| security_key  | varchar(255) | NO   |     | NULL    |                |
