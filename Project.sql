CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (
   Branch_No INT PRIMARY KEY,
   Manager_Id INT,
   Branch_Address VARCHAR(100),
   Contact_No VARCHAR(15)
);

INSERT INTO Branch VALUES (1, 201, '123 Main St, New York, NY', '2125550101');
INSERT INTO Branch VALUES (2, 202, '456 Elm St, Los Angeles, CA', '3105550202');
INSERT INTO Branch VALUES (3, 203, '789 Pine Ave, Chicago, IL', '3125550303');
INSERT INTO Branch VALUES (4, 204, '321 Maple Dr, Houston, TX', '7135550404');
INSERT INTO Branch VALUES (5, 205, '555 Birch Blvd, Miami, FL', '3055550505');

SELECT * FROM Branch;

CREATE TABLE Employee (
   Emp_Id INT PRIMARY KEY,
   Emp_Name VARChAR(50),
   Position VARCHAR(50),
   Salary DECIMAL(10,2),
   Branch_No INT,
   FOREIGN KEY (Branch_No) REFERENCES Branch(Branch_No)
);

INSERT INTO Employee VALUES (1, 'Emma Johnson', 'Branch Manager', 70000, 1);
INSERT INTO Employee VALUES (2, 'Liam Smith', 'Assistant Manager', 50000, 1);
INSERT INTO Employee VALUES (3, 'Olivia Brown', 'Librarian', 45000, 2);
INSERT INTO Employee VALUES (4, 'Noah Davis', 'Library Clerk', 35000, 3);
INSERT INTO Employee VALUES (5, 'Sophia Wilson', 'Assistant Librarian', 40000, 4);

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
INSERT INTO Books VALUES ('9781492078005', 'Database Internals', 'Databases', 50.00, 'Yes', 'Alex Petrov', 'O\'Reilly Media');
INSERT INTO Books VALUES ('9780132350884', 'The Pragmatic Programmer', 'Programming', 35.00, 'Yes', 'Andrew Hunt', 'Addison-Wesley');
INSERT INTO Books VALUES ('9780596007126', 'The Art of Unix Programming', 'Operating Systems', 30.00, 'No', 'Eric S. Raymond', 'O\'Reilly Media');
INSERT INTO Books VALUES ('9780201616224', 'The Mythical Man-Month', 'Software Engineering', 30.00, 'Yes', 'Frederick P. Brooks Jr.', 'Addison-Wesley');
INSERT INTO Books VALUES ('9780131103627', 'The C Programming Language', 'Programming', 40.00, 'No', 'Brian W. Kernighan and Dennis M. Ritchie', 'Prentice Hall');

SELECT * FROM Books;

CREATE TABLE Customer (
   Customer_Id INT PRIMARY KEY,
   Customer_Name VARCHAR(50),
   Customer_Address VARCHAR(100),
   Reg_Date date
);

INSERT INTO Customer VALUES (1, 'Michael Carter', '456 Cedar Rd, Boston, MA', '2021-11-10');
INSERT INTO Customer VALUES (2, 'Jessica Lee', '789 Aspen St, Seattle, WA', '2022-03-14');
INSERT INTO Customer VALUES (3, 'Daniel Young', '123 Walnut Ave, Denver, CO', '2021-12-01');
INSERT INTO Customer VALUES (4, 'Emily Harris', '321 Spruce Blvd, Atlanta, GA', '2023-01-20');
INSERT INTO Customer VALUES (5, 'Matthew Perez', '555 Oak Ln, Phoenix, AZ', '2022-06-30');

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

INSERT INTO Issue_Status VALUES (1, 1, 'Design Patterns', '2023-06-10', '9780321125217');
INSERT INTO Issue_Status VALUES (2, 2, 'Database Internals', '2023-06-12', '9781492078005');
INSERT INTO Issue_Status VALUES (3, 3, 'The Art of Unix Programming', '2023-07-15', '9780596007126');
INSERT INTO Issue_Status VALUES (4, 4, 'Clean Code', '2023-07-18', '9780135166307');
INSERT INTO Issue_Status VALUES (5, 5, 'The Pragmatic Programmer', '2023-08-05', '9780132350884');

SELECT * FROM Issue_Status;

CREATE TABLE Return_Status (
   Return_Id INT PRIMARY KEY,
   Return_Cust VARCHAR(50),
   Return_Book_Name VARCHAR(100),
   Return_Date DATE,
   ISBN_Book2 VARCHAR(20),
   FOREIGN KEY (ISBN_Book2) REFERENCES Books(ISBN)
);

INSERT INTO Return_Status VALUES (1, 1, 'Design Patterns', '2023-07-01', '9780321125217');
INSERT INTO Return_Status VALUES (2, 2, 'Database Internals', '2023-07-10', '9781492078005');
INSERT INTO Return_Status VALUES (3, 3, 'The Art of Unix Programming', '2023-07-25', '9780596007126');
INSERT INTO Return_Status VALUES (4, 4, 'Clean Code', '2023-08-01', '9780135166307');
INSERT INTO Return_Status VALUES (5, 5, 'The Pragmatic Programmer', '2023-08-15', '9780132350884');

SELECT * FROM Return_Status;

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_Title, Category, Rental_Price FROM Books WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_Name, Salary FROM Employee ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT B.Book_Title, C.Customer_Name FROM Books B
JOIN Issue_Status I ON B.ISBN = I.ISBN_Book
JOIN Customer C ON I.Issued_Cust = C.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS No_of_Books FROM Books GROUP BY Category;


