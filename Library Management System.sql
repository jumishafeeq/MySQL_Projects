CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (
   Branch_No INT PRIMARY KEY,
   Manager_Id INT,
   Branch_Address VARCHAR(100),
   Contact_No VARCHAR(15)
);

INSERT INTO Branch VALUES (101, 101, '123 Main St, New York, NY', '2125550101');
INSERT INTO Branch VALUES (102, 106, '456 Elm St, Los Angeles, CA', '3105550202');
INSERT INTO Branch VALUES (103, 112, '789 Pine Ave, Chicago, IL', '3125550303');
INSERT INTO Branch VALUES (104, 105, '321 Maple Dr, Houston, TX', '7135550404');

SELECT * FROM Branch;

CREATE TABLE Employee (
   Emp_Id INT PRIMARY KEY,
   Emp_Name VARChAR(50),
   Position VARCHAR(50),
   Salary DECIMAL(10,2),
   Branch_No INT,
   FOREIGN KEY (Branch_No) REFERENCES Branch(Branch_No)
);

INSERT INTO Employee VALUES (101, 'Emma Johnson', 'Branch Manager', 70000, 101);
INSERT INTO Employee VALUES (102, 'Liam Smith', 'Assistant Manager', 52000, 101);
INSERT INTO Employee VALUES (103, 'Olivia Brown', 'Librarian', 45000, 102);
INSERT INTO Employee VALUES (104, 'Noah Davis', 'Library Clerk', 35000, 103);
INSERT INTO Employee VALUES (105, 'Sophia Wilson', 'Manager', 40000, 104);
INSERT INTO Employee VALUES (106, 'Jame Smith', 'Branch Manager', 55000, 102);
INSERT INTO Employee VALUES (107, 'Sara James', 'Librarian', 45000, 101);
INSERT INTO Employee VALUES (108, 'Lucas Evans', 'Librarian', 32000, 104);
INSERT INTO Employee VALUES (109, 'Mia Martinez', 'Clerk', 20000, 101);
INSERT INTO Employee VALUES (110, 'Samuel John', 'Library Assistant', 25000, 101);
INSERT INTO Employee VALUES (111, 'John loocas', 'Manager', 30000, 101);
INSERT INTO Employee VALUES (112, 'Lia Thomas', 'Branch Manager', 50000, 103);

SELECT * FROM Employee;

CREATE TABLE Books (
   ISBN VARCHAR(20) PRIMARY KEY,
   Book_Title VARCHAR(100),
   Category VARCHAR(100),
   Rental_Price DECIMAL(10,2),
   Status VARCHAR(3),
   Author VARCHAR(50),
   Publisher VARCHAR(50)
);

INSERT INTO Books VALUES ('9780135166307', 'Clean Code', 'Programming', 40.00, 'Yes', 'Robert C. Martin', 'Prentice Hall');
INSERT INTO Books VALUES ('9780321125217', 'Design Patterns', 'Software Engineering', 45.00, 'No', 'Erich Gamma et al.', 'Addison-Wesley');
INSERT INTO Books VALUES ('9780132350884', 'The Pragmatic Programmer', 'Programming', 35.00, 'Yes', 'Andrew Hunt', 'Addison-Wesley');
INSERT INTO Books VALUES ('9780596007126', 'The Art of Unix Programming', 'Operating Systems', 25.00, 'No', 'Eric S. Raymond', 'O\'Reilly Media');
INSERT INTO Books VALUES ('9780201616224', 'The Mythical Man-Month', 'Software Engineering', 30.00, 'Yes', 'Frederick P. Brooks Jr.', 'Addison-Wesley');
INSERT INTO Books VALUES ('9780131103627', 'The C Programming Language', 'Programming', 40.00, 'No', 'Brian W. Kernighan and Dennis M. Ritchie', 'Prentice Hall');
INSERT INTO Books VALUES ('9780307275905', 'Guns, Germs, and Steel', 'History', 45.00, 'No', 'Jared Diamond', 'W.W. Norton & Company');
INSERT INTO Books VALUES ('9780670024795', 'Sapiens: A Brief History of Humankind', 'History', 60.00, 'Yes', 'Yuval Noah Harari', 'Harper');

SELECT * FROM Books;

CREATE TABLE Customer (
   Customer_Id INT PRIMARY KEY,
   Customer_Name VARCHAR(50),
   Customer_Address VARCHAR(100),
   Reg_Date date
);

INSERT INTO Customer VALUES (101, 'Michael Carter', '456 Cedar Rd, Boston, MA', '2023-11-10');
INSERT INTO Customer VALUES (102, 'Jessica Lee', '789 Aspen St, Seattle, WA', '2022-03-14');
INSERT INTO Customer VALUES (103, 'Daniel Young', '123 Walnut Ave, Denver, CO', '2021-12-01');
INSERT INTO Customer VALUES (104, 'Emily Harris', '321 Spruce Blvd, Atlanta, GA', '2023-01-20');
INSERT INTO Customer VALUES (105, 'Matthew Perez', '555 Oak Ln, Phoenix, AZ', '2022-06-30');
INSERT INTO Customer VALUES (106, 'Rose Mary', '987 Liberty Rd, Philadelphia, PA', '2021-12-25');
INSERT INTO Customer VALUES (107, 'Amelia Jon', '123 Pioneer St, Kansas City, MO', '2021-04-10');

SELECT * FROM Customer;

CREATE TABLE Issue_Status (
   Issue_Id INT PRIMARY KEY,
   Issued_Cust INT,
   Issued_Book_Name VARCHAR(100),
   Issue_Date DATE,
   ISBN_Book VARCHAR(20),
   FOREIGN KEY (Issued_Cust) REFERENCES Customer(Customer_Id),
   FOREIGN KEY (ISBN_Book) REFERENCES Books(ISBN)
);

INSERT INTO Issue_Status VALUES (1001, 103, 'Design Patterns', '2023-06-10', '9780321125217');
INSERT INTO Issue_Status VALUES (1002, 101, 'Sapiens: A Brief History of Humankind', '2023-06-12', '9780670024795');
INSERT INTO Issue_Status VALUES (1003, 102, 'The Art of Unix Programming', '2023-07-15', '9780596007126');
INSERT INTO Issue_Status VALUES (1004, 105, 'Clean Code', '2023-07-18', '9780135166307');
INSERT INTO Issue_Status VALUES (1005, 104, 'The Pragmatic Programmer', '2023-08-05', '9780132350884');

SELECT * FROM Issue_Status;

CREATE TABLE Return_Status (
   Return_Id INT PRIMARY KEY,
   Return_Cust VARCHAR(50),
   Return_Book_Name VARCHAR(100),
   Return_Date DATE,
   ISBN_Book2 VARCHAR(20),
   FOREIGN KEY (ISBN_Book2) REFERENCES Books(ISBN)
);

INSERT INTO Return_Status VALUES (1001, 103, 'Design Patterns', '2023-07-01', '9780321125217');
INSERT INTO Return_Status VALUES (1002, 101, 'Sapiens: A Brief History of Humankind', '2023-07-10', '9780670024795');
INSERT INTO Return_Status VALUES (1003, 102, 'The Art of Unix Programming', '2023-07-25', '9780596007126');
INSERT INTO Return_Status VALUES (1004, 105, 'Clean Code', '2023-08-01', '9780135166307');
INSERT INTO Return_Status VALUES (1005, 104, 'The Pragmatic Programmer', '2023-08-15', '9780132350884');

SELECT * FROM Return_Status;

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_Title, Category, Rental_Price FROM Books 
WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_Name, Salary FROM Employee 
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT B.Book_Title, C.Customer_Name FROM Books B
JOIN Issue_Status I ON B.ISBN = I.ISBN_Book
JOIN Customer C ON I.Issued_Cust = C.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books FROM Books 
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_Name, Position FROM Employee 
WHERE Salary > 50000; 

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_Name, Reg_Date FROM Customer 
WHERE Reg_Date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_Cust FROM Issue_Status);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_No, COUNT(*) AS Total_Employees FROM Employee 
GROUP BY Branch_No;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT Customer_Name FROM Customer WHERE Customer_Id IN (
   SELECT Issued_Cust FROM Issue_Status 
   WHERE MONTH(Issue_Date) = '6' 
   AND YEAR(Issue_Date) = '2023');

-- 9. Retrieve book_title from book table containing history.
SELECT Book_Title, Category FROM Books 
WHERE Category LIKE '%History%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
SELECT Branch_No, COUNT(*) AS Total_Employees FROM Employee 
GROUP BY Branch_No
HAVING Total_Employees > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_Name, B.Branch_Address FROM Employee E
JOIN Branch B ON E.Branch_No = B.Branch_No
WHERE Position = 'Branch Manager';

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT C.Customer_Name, B.Book_Title, B.Rental_Price FROM Customer C 
JOIN Issue_Status I ON C.Customer_Id = I.Issued_Cust
JOIN Books B ON I.ISBN_Book = B.ISBN
WHERE B.Rental_Price > 25;
