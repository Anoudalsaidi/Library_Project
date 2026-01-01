create database Library_project
use Library_project
----------------------------------------------------------------------------------------Creation Table
Create table Libraries(                                               
Library_ID INT PRIMARY KEY IDENTITY(1,1),
Library_Name VARCHAR(50) NOT NULL UNIQUE,
Library_Location VARCHAR(50) NOT NULL,
ContactNumber VARCHAR(20) NOT NULL
)
Create table Members(
 Member_ID INT PRIMARY KEY IDENTITY(1,1),
 Member_FullName VARCHAR(50),
 Member_Email VARCHAR(50) NOT NULL UNIQUE,
 Membership_StartDate DATE NOT NULL
 )
Create table Books (
Book_ID INT PRIMARY KEY IDENTITY(1,1),
ISBN VARCHAR(20) NOT NULL UNIQUE,
Book_Title VARCHAR(50) NOT NULL,
Book_Genre VARCHAR(20) NOT NULL,
CONSTRAINT CK_Book_Genre CHECK (Book_Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children') ),
Book_IsAvailable BIT NOT NULL DEFAULT 1,
ShelfLocation VARCHAR(50) NOT NULL,
Book_Price DECIMAL(10,2) CHECK (Book_Price > 0),
Library_ID INT NOT NULL,
CONSTRAINT FK_Book_Library FOREIGN KEY (Library_ID) REFERENCES Libraries(Library_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
)
Create table Loan (
Loan_ID INT PRIMARY KEY IDENTITY(1,1),
LoanDate DATE NOT NULL,
DueDate DATE NOT NULL,
ReturnDate DATE,
CONSTRAINT CK_Loan_ReturnDate CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate),
Loan_Status VARCHAR(20) NOT NULL DEFAULT 'Issued',
CONSTRAINT CK_Loan_Status CHECK (Loan_Status IN ('Issued', 'Returned', 'Overdue')),
Book_ID INT NOT NULL,
Member_ID INT NOT NULL,
CONSTRAINT FK_Book_ID FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Member_ID FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
)
Create table staff_library(
staff_ID INT PRIMARY KEY IDENTITY(1,1),
staff_fullName VARCHAR(50) NOT NULL,
Position VARCHAR(50),
ContactNumber VARCHAR(20) NOT NULL,
Library_ID INT NOT NULL,
CONSTRAINT FK_Books_Library FOREIGN KEY (Library_ID) REFERENCES Libraries(Library_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
)
Create table Payment (
Payment_ID INT PRIMARY KEY IDENTITY(1,1),
Payment_Date DATE NOT NULL,
payment_Methed VARCHAR(20),
Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
Loan_ID INT NOT NULL,
CONSTRAINT FK_Loan_ID FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
)
Create table Reviews (
Review_ID INT PRIMARY KEY IDENTITY(1,1),
Rating INT NOT NULL,
CONSTRAINT CK_Review_Rating CHECK (Rating BETWEEN 1 AND 5),
Comments VARCHAR(255) NOT NULL DEFAULT 'No comments',
ReviewDate DATE NOT NULL,
Book_ID INT NOT NULL,
Member_ID INT NOT NULL,
CONSTRAINT FK_BookID_R FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Member_R FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
)

ALTER TABLE Libraries 
ADD Establish_year int
---------------------------------------------------------------------------------------Insertion Records
insert into Libraries (Library_Name,Library_Location,ContactNumber,Establish_year)
VALUES('Central Library','Muscat','9111111',2025),('City Library','Sohar','9222222',2024),('Uni Library','Salalah','9333333',2020)

Select * from Libraries

insert into Members(Member_FullName,Member_Email,Membership_StartDate)
VALUES ('Ali Ahmed', 'ali@email.com', '2024-01-15'),('Sara Mohammed', 'sara@email.com', '2024-02-01'),('Omar Khaled', 'omar@email.com', '2024-03-10')

Select * from Members

insert into Books (ISBN,Book_Title,Book_Genre,Book_IsAvailable,ShelfLocation,Book_Price,Library_ID)
VALUES ('0131103', 'Introduction to Programming', 'Reference', 1, 'A-12', 12.50, 1),('321380', 'Database Systems', 'Non-fiction', 1, 'B-05', 9.00, 1),('043190', 'Harry Potter', 'Children', 1, 'C-01', 45.75, 2)

Select * from Books

insert into Loan(LoanDate,DueDate,ReturnDate,Loan_Status,Book_ID,Member_ID)
VALUES ('2024-04-01', '2024-04-15', NULL, 'Issued', 1, 1),('2024-03-01', '2024-03-10', '2024-03-09', 'Returned', 2, 2),('2024-04-10', '2024-04-20', '2024-04-22', 'Overdue', 1, 1)

Select * from Loan

insert into staff_library (staff_fullName,Position,ContactNumber,Library_ID)
VALUES ('Saleh', 'Librarian', '999999', 1),('Anoud', 'Assistant Librarian', '4444444', 1),('Mohammed', 'Manager', '6666666', 2)

Select * from staff_library

insert into Payment (Payment_Date,payment_Methed,Amount,Loan_ID)
VALUES ('2025-12-01', 'Cash', 12.50, 1),('2025-12-05', 'Credit Card', 9.00, 2),('2025-12-10', 'Bank Transfer', 45.75, 3)

Select * from Payment

insert into Reviews (Rating,Comments,ReviewDate,Book_ID,Member_ID)
VALUES (5, 'Excellent book, highly recommend!', '2025-12-01', 1, 1),(4, 'Good read, but a bit lengthy.', '2025-12-05', 2, 2),(3, 'Average content, could be better.', '2025-12-10', 3, 3)

Select * from Reviews 


