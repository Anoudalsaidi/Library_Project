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

ALTER TABLE Members
ADD PhoneNumber VARCHAR(20)
---------------------------------------------------------------------------------------Insertion Records
insert into Libraries (Library_Name,Library_Location,ContactNumber,Establish_year)
VALUES('Central Library','Muscat','9111111',2025),('City Library','Sohar','9222222',2024),('Uni Library','Salalah','9333333',2020)

Select * from Libraries

INSERT INTO Members (Member_FullName, Member_Email, Membership_StartDate, PhoneNumber)
VALUES 
('Ali Ahmed', 'al7i@email.com', '2024-01-15', '911111111'),
('Sara Mohammed', 's7ara@email.com', '2024-02-01', '922222222'),
('Omar Khaled', 'om7ar@email.com', '2024-03-10', '933333333'),
('Hassan Ali', 'hassa1@email.com', '2024-01-01', '944444444'),
('Mona Said', 'mon2@email.com', '2024-01-05', '955555555'),
('Yousef Nasser', 'yusef3@email.com', '2024-01-10', '966666666'),
('Aisha Salem', 'aisa4@email.com', '2024-01-15', '977777777'),
('Khalid Omar', 'khlid5@email.com', '2024-02-01', '988888888'),
('Fatma Ahmed', 'fama6@email.com', '2024-02-10', '999999999'),
('Nasser Hamed', 'naser7@email.com', '2024-02-20', '900000000'),
('Noor Rashid', 'nor8@email.com', '2024-03-01', '911111112'),
('Majed Ibrahim', 'mjed9@email.com', '2024-03-05', '922222223'),
('Laila Fares', 'laia10@email.com', '2024-03-10', '933333334')


Select * from Members

INSERT INTO Books (ISBN, Book_Title, Book_Genre, Book_IsAvailable, ShelfLocation, Book_Price, Library_ID)
VALUES
('1303', 'SQL Basics', 'Reference', 1, 'A-01', 10.00, 1),
('1002', 'Advanced SQL', 'Reference', 1, 'A-02', 15.00, 1),
('1003', 'Cyber Security 101', 'Non-fiction', 1, 'B-01', 18.00, 1),
('1004', 'Networking Basics', 'Non-fiction', 1, 'B-02', 14.50, 1),
('1005', 'Data Analysis', 'Non-fiction', 1, 'B-03', 20.00, 1),
('1006', 'Fairy Tales', 'Children', 1, 'C-02', 8.00, 2),
('1007', 'Short Stories', 'Fiction', 1, 'D-01', 9.50, 2),
('1008', 'Mystery Night', 'Fiction', 1, 'D-02', 11.00, 2),
('1009', 'Science for Kids', 'Children', 1, 'C-03', 7.75, 2),
('1010', 'History of Oman', 'Non-fiction', 1, 'B-04', 16.00, 2),
('1011', 'Python Programming', 'Reference', 1, 'A-03', 19.00, 1),
('1012', 'Java Basics', 'Reference', 1, 'A-04', 17.00, 1),
('1013', 'Cloud Computing', 'Non-fiction', 1, 'B-06', 21.00, 1),
('1014', 'AI Fundamentals', 'Non-fiction', 1, 'B-07', 22.50, 1),
('1015', 'Digital Logic', 'Reference', 1, 'A-05', 13.00, 1),
('1016', 'Kids Mathematics', 'Children', 1, 'C-04', 6.50, 2),
('1017', 'Fantasy World', 'Fiction', 1, 'D-03', 12.00, 2),
('1018', 'Modern Physics', 'Non-fiction', 1, 'B-08', 23.00, 3),
('1019', 'Chemistry Basics', 'Reference', 1, 'A-06', 14.00, 3),
('1020', 'English Grammar', 'Reference', 1, 'A-07', 11.50, 3)

Select * from Books

INSERT INTO Loan (LoanDate, DueDate, ReturnDate, Loan_Status, Book_ID, Member_ID)
VALUES
('2024-03-01','2024-04-15',NULL,'Issued',1,1),
('2024-01-01','2024-08-10','2024-03-09','Returned',2,2),
('2024-04-10','2024-05-20','2024-04-22','Overdue',3,3),
('2024-05-01','2024-05-10',NULL,'Issued',1011,405),
('2024-05-02','2024-05-12','2024-05-12','Returned',1013,413),
('2024-05-03','2024-05-13',NULL,'Issued',1014,414),
('2024-05-04','2024-05-14','2024-05-15','Overdue',1015,415),
('2024-05-05','2024-05-15','2024-05-14','Returned',1016,416),
('2024-05-06','2024-05-16',NULL,'Issued',1017,417),
('2024-05-07','2024-05-17','2024-05-18','Overdue',1018,418),
('2024-05-08','2024-05-18',NULL,'Issued',1019,419),
('2024-05-09','2024-05-19','2024-05-19','Returned',1020,420),
('2024-05-10','2024-05-20',NULL,'Issued',1021,421),
('2024-05-11','2024-05-21','2024-05-22','Overdue',1022,422),
('2024-05-12','2024-05-22',NULL,'Issued',1023,423)


Select * from Loan


SELECT Member_ID, Member_FullName
FROM Members

insert into staff_library (staff_fullName,Position,ContactNumber,Library_ID)
VALUES ('Saleh', 'Librarian', '999999', 1),('Anoud', 'Assistant Librarian', '4444444', 1),('Mohammed', 'Manager', '6666666', 2)

Select * from staff_library


insert into Payment (Payment_Date,payment_Methed,Amount,Loan_ID)
VALUES ('2025-12-01', 'Cash', 12.50, 57),
       ('2025-12-05', 'Credit Card', 9.00, 60),
       ('2025-12-10', 'Bank Transfer', 45.75, 64)

Select * from Payment

insert into Reviews (Rating,Comments,ReviewDate,Book_ID,Member_ID)
VALUES (5, 'Excellent book, highly recommend!', '2025-12-01', 1, 1),(4, 'Good read, but a bit lengthy.', '2025-12-05', 2, 2),(3, 'Average content, could be better.', '2025-12-10', 3, 3)

Select * from Reviews 


UPDATE Books
SET Published_Year = 2020
WHERE Published_Year IS NULL




-------------------------------------------------------------------------------------++PART-2
-----SECTION 1:------

---1. Library Book Inventory Report

select l.Library_Name,count(b.Book_ID) AS TotalBooks,
SUM(CASE WHEN B.Book_IsAvailable = 1 THEN 1 ELSE 0 END) AS Available_Books,
SUM(CASE WHEN o.Loan_Status = 'Issued'  THEN 1 ELSE 0 END) AS Books_On_Loan
from  Books b
Join  Libraries l on b.Library_ID = l.Library_ID
JOIN  Loan o on b.Book_ID = o.Book_ID
Group by l.Library_Name

Select * from Books
Select * from Libraries
Select * from Loan

---2. Active Borrowers Analysis

select m.Member_FullName,m.Member_Email,b.Book_Title,o.LoanDate,o.DueDate,o.Loan_Status
from Loan o
Join Members m on m.Member_ID = o.Member_ID
Join Books b on b.Book_ID = o.Book_ID
where o.Loan_Status in ('Issued','Overdue')

---3. Overdue Loans with Member Details
select m.Member_FullName,b.Book_Title,Lb.Library_Name,
Datediff(day,L.LoanDate,L.DueDate) AS Days_Overdue,
ISNULL(P.Amount,0) AS Fines_Paid

 FROM Loan L
JOIN Members M ON L.Member_ID = M.Member_ID
JOIN Books B ON L.Book_ID = B.Book_ID
JOIN Libraries Lb ON B.Library_ID = Lb.Library_ID
JOIN Payment P ON L.Loan_ID = P.Loan_ID
WHERE L.Loan_Status = 'Overdue'

Select * from Payment

---4. Staff Performance Overview
select l.Library_Name,ss.staff_fullName,ss.Position,
count (b.Book_ID) AS Books_Managed
from staff_library ss
JOIN Libraries l ON ss.Library_ID = l.Library_ID
JOIN Books B ON l.Library_ID = b.Library_ID
GROUP BY l.Library_Name, ss.staff_fullName, ss.Position


select * from staff_library
select * from Books
select * from Libraries

---5. Book Popularity Report -----comment(Because I do not have books which were loaned more than 1, 
---   I changed the question from 3 to at least 1 to see the result)

select b.Book_Title,b.ISBN,b.Book_Genre,
count(l.Loan_ID) AS Total_Loaned,AVG(R.Rating) as Avg_Review_Rating
from Books b
Join Reviews R ON b.Book_ID = R.Book_ID
Join Loan l ON b.Book_ID = l.Book_ID
Group by b.Book_Title,b.ISBN,b.Book_Genre
Having count(l.Loan_ID) >= 3


--- 6. Member Reading History
select m.Member_FullName,b.Book_Title,l.LoanDate,l.ReturnDate,r.Rating,r.Comments
from Members m
JOIN Loan l ON m.Member_ID = l.Member_ID
JOIN Books b ON l.Book_ID = b.Book_ID
left JOIN Reviews r ON m.Member_ID = r.Member_ID
AND B.Book_ID = R.Book_ID

----7. Revenue Analysis by Genre
select b.Book_Genre,count(l.Loan_ID) AS Total_Loans,SUM(isnull(P.Amount,0)) as Total_Amounts,
avg(isnull(P.Amount,0)) as Avg_Fine_Per_Loan
from Books b
Join Loan l on b.Book_ID = l.Book_ID
Join Payment p on l.Loan_ID = p.Loan_ID
GROUP BY B.Book_Genre


-----SECTION 2:------

--- 8. Monthly Loan Statistics

select 
DATENAME(month,LoanDate) AS Month_Name,
count(*) AS Total_Loans,
sum(Case when Loan_Status ='Returned' THEN 1 else 0 END) AS Total_returned,

sum(case when Loan_Status IN ('Issued','Overdue') THEN 1 else 0 END) AS Total_Issued_OrOverdue

FROM Loan

WHERE YEAR(LoanDate) = YEAR(GETDATE())
GROUP BY DATENAME(month,LoanDate) , month(LoanDate) 

select * from Loan
----- Because I didn’t have any loan in 2025



--- 9. Member Engagement Metrics
select m.Member_FullName,
count(l.Loan_ID) as Total_Books_Borrowed,

sum(case when l.Loan_Status in ('Issued','Overdue') then 1 else 0 end) as Total_Books_on_Loans,
sum(isnull(p.Amount,0)) AS Total_Fines_Paid,
avg(r.Rating) AS Avg_Rating
from Loan l
Join Members m on m.Member_ID = l.Member_ID
Join Payment p on l.Loan_ID = p.Loan_ID
Join Reviews r on m.Member_ID = r.Member_ID
Group by m.Member_FullName
having count(l.Loan_ID) >= 1

select * from Members

--- 10. Library Performance Comparison
select l.Library_Name,
count(b.Book_ID) AS Total_Books_Owned,

count(DISTINCT case when lo.Loan_ID IS NOT NULL THEN lo.Member_ID END) AS Total_Active_Members,
sum(isnull(p.Amount,0)) as Total_Fines_Paid,

cast(count(b.Book_ID) * 1.0 / nullif(count(DISTINCT lo.Member_ID),0)AS DECIMAL(10,2)) as Avg_Books_Per_Member

from Libraries l
Join books b on l.Library_ID = b.Library_ID
LEFT JOIN Loan lo ON b.Book_ID = lo.Book_ID
LEFT JOIN Payment p ON lo.Loan_ID = p.Loan_ID
Group by l.Library_Name


--- 11. High-Value Books Analysis
SELECT 
    b.Book_Title,
    b.Book_Genre,
    b.Book_Price,

    AVG(b2.Book_Price) AS Genre_Avg_Price,
    b.Book_Price - AVG(b2.Book_Price) AS Price_Difference

FROM Books b
JOIN Books b2 ON b.Book_Genre = b2.Book_Genre
GROUP BY b.Book_ID, b.Book_Title, b.Book_Genre, b.Book_Price
HAVING b.Book_Price > AVG(b2.Book_Price)



--- 12. Payment Pattern Analysis
select payment_Methed,
count(Payment_ID) as Transactions_Type,
sum(Amount) as Total_Amount,
avg(Amount) as Avg_payment_Amount,
cast(sum(Amount) * 100 / (select sum(Amount) from Payment) AS DECIMAL(5,2)) as Prnctage_of_Total_Revenue
from Payment
Group by payment_Methed

select * from Payment


-----SECTION 3:------

--- 13. vw_CurrentLoans

CREATE VIEW vw_CurrentLoans AS
SELECT 
    l.Loan_ID,m.Member_FullName,m.Member_Email,b.Book_Title,b.Book_Genre,lb.Library_Name,
    l.LoanDate,
    l.DueDate,
    l.Loan_Status,
    CASE 
        WHEN l.Loan_Status = 'Overdue' THEN DATEDIFF(DAY, l.DueDate, GETDATE())
        ELSE DATEDIFF(DAY, GETDATE(), l.DueDate)
    END AS Days_Until_Due_Or_Overdue
FROM Loan l
JOIN Members m ON l.Member_ID = m.Member_ID
JOIN Books b ON l.Book_ID = b.Book_ID
JOIN Libraries lb ON b.Library_ID = lb.Library_ID
WHERE l.Loan_Status IN ('Issued','Overdue')

select * from vw_CurrentLoans

--- 14. vw_LibraryStatistics

CREATE VIEW vw_LibraryStatistics AS

SELECT lb.Library_ID,lb.Library_Name,
COUNT( b.Book_ID) AS Total_Books,
Sum(case when b.Book_IsAvailable = 1 then 1 else 0 end) as Available_Books,
count(m.Member_ID) AS Total_Members,
count(case when l.Loan_Status in ('Issued','Overdue') then 1 else 0 end) as Active_Loans,
count(s.staff_ID) as Total_Saff,
sum(ISNULL(p.Amount,0)) as Total_revenue

from Libraries lb 
Join Books b on lb.Library_ID = b.Library_ID
JOIN Loan l ON b.Book_ID = l.Book_ID
JOIN Members m ON l.Member_ID = m.Member_ID
JOIN staff_library s ON lb.Library_ID = s.Library_ID
JOIN Payment p ON l.Loan_ID = p.Loan_ID
GROUP BY lb.Library_ID, lb.Library_Name

select * from vw_LibraryStatistics
select * from Books
select * from loan
select * from Libraries

--- 15. vw_BookDetailsWithReview

CREATE VIEW vw_BookDetailsWithReviews AS

select b.Book_ID,b.Book_Title,b.ISBN,b.Book_Genre,b.Book_Price,b.ShelfLocation,b.Book_IsAvailable,
count(r.Review_ID) as Total_Review,
avg(r.Rating) AS Avg_Rating,
MAX(r.ReviewDate) AS Latest_Review_Date

from Books b
JOIN Reviews r ON b.Book_ID = r.Book_ID
Group by b.Book_ID, b.Book_Title, b.ISBN, b.Book_Genre, b.Book_Price, b.ShelfLocation, b.Book_IsAvailable

select * from vw_BookDetailsWithReviews



-----SECTION 4:------

--- 16. sp_IssueBook

CREATE PROCEDURE sp_IssueBook
    @MemberID int,
    @BookID int,
    @DueDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        -- Check if book is available
        IF NOT EXISTS(
            SELECT 1
            FROM Books
            WHERE Book_ID = @BookID AND Book_IsAvailable = 1
        )
        BEGIN
            PRINT 'SORRY, THIS BOOK IS NOT AVAILABLE';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check if member has any overdue loans
        IF EXISTS(
            SELECT 1
            FROM Loan
            WHERE Member_ID = @MemberID AND Loan_Status = 'Overdue'
        )
        BEGIN
            PRINT 'SORRY, MEMBER HAS OVERDUE LOAN';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert new loan record
        INSERT INTO Loan (LoanDate, DueDate, Loan_Status, Book_ID, Member_ID)
        VALUES (GETDATE(), @DueDate, 'Issued', @BookID, @MemberID);

        -- Update book availability
        UPDATE Books
        SET Book_IsAvailable = 0
        WHERE Book_ID = @BookID;

        -- Commit transaction if everything is fine
        COMMIT TRANSACTION;
        PRINT 'Success: Book issued successfully.';

    END TRY
    BEGIN CATCH
        -- Rollback if any error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'Transaction failed. Rolling back changes.';
        PRINT ERROR_MESSAGE();  -- Shows error details
    END CATCH
END

EXEC sp_IssueBook 
    @MemberID = 1,
    @BookID = 1,
    @DueDate = '2025-01-20'

	SELECT * FROM Loan --- TO CHECK 


--- 17. sp_ReturnBook

CREATE PROCEDURE ssp_ReturnBook
    @LoanID INT,
    @ReturnDate DATE
AS
BEGIN
    DECLARE @DueDate DATE
    DECLARE @BookID INT
    DECLARE @FineAmount DECIMAL(10,2) = 0

SELECT 
        @DueDate = DueDate, @BookID = Book_ID
    FROM Loan
    WHERE Loan_ID = @LoanID

 IF @ReturnDate > @DueDate
        SET @FineAmount = DATEDIFF(DAY, @DueDate, @ReturnDate) * 2  -----  -- Calculate fine

UPDATE Loan         -- Update loan       
    SET ReturnDate = @ReturnDate,
        Loan_Status = 'Returned'
    WHERE Loan_ID = @LoanID

UPDATE Books    -- Update book availability    
    SET Book_IsAvailable = 1
    WHERE Book_ID = @BookID

 -- Insert payment if fine exists
    IF @FineAmount > 0
    BEGIN
        INSERT INTO Payment (Payment_Date,payment_Methed, Amount,Loan_ID)
         VALUES (GETDATE(),'pending',@FineAmount,@LoanID)
END

    SELECT @FineAmount AS TotalFine
END

EXEC ssp_ReturnBook 
    @LoanID = 51,
    @ReturnDate = '2024-04-20'


	EXEC ssp_ReturnBook 
    @LoanID = 52,
    @ReturnDate = '2024-04-15'
	--- to check
SELECT Loan_ID, DueDate, ReturnDate, Loan_Status, Book_ID  
FROM Loan
WHERE ReturnDate IS NULL

SELECT Loan_ID, DueDate
FROM Loan
WHERE Loan_ID = 51   ---returndate (2024-4-15)


SELECT Loan_Status, ReturnDate  ---check book has returened 
FROM Loan
WHERE Loan_ID = 51

SELECT Book_IsAvailable     ----check book is available
FROM Books
WHERE Book_ID = (
    SELECT Book_ID FROM Loan WHERE Loan_ID = 51
)

SELECT *                --- fine has been calculated
FROM Payment
WHERE Loan_ID = 51


--- 18. sp_GetMemberReport

CREATE PROCEDURE sp_GetMemberReport
    @MemberID INT
AS
BEGIN
   
    SELECT *           ----member information
    FROM Members
    WHERE Member_ID = @MemberID;

   
    SELECT *          -----current loan
    FROM Loan
    WHERE Member_ID = @MemberID
      AND ReturnDate IS NULL;

  
    SELECT *        ----loan register
    FROM Loan
    WHERE Member_ID = @MemberID;

                    --- total loan
    SELECT SUM(P.Amount) AS TotalFines
    FROM Payment P
    JOIN Loan L ON P.Loan_ID = L.Loan_ID
    WHERE L.Member_ID = @MemberID

                    ---- reviews
    SELECT *
    FROM Reviews
    WHERE Member_ID = @MemberID;
END

EXEC sp_GetMemberReport @MemberID = 1

SELECT Member_ID, Member_FullName
FROM Members
--- Member_ID = 1


SELECT * 
FROM Members
WHERE Member_ID = 1

---The procedure was executed successfully and returned multiple result sets including member details, 
---current loans, loan history, total fines, and reviews.


--- 19. sp_MonthlyLibraryReport
CREATE PROCEDURE sp_MonthlyLibraryReport
    @LibraryID INT,
    @Month INT,
    @Year INT
AS
BEGIN
                                   -- number of loan
    SELECT COUNT(*) AS TotalLoans
    FROM Loan L
    JOIN Books B ON L.Book_ID = B.Book_ID
    WHERE B.Library_ID = @LibraryID
      AND MONTH(L.LoanDate) = @Month
      AND YEAR(L.LoanDate) = @Year;

                                    -- number of returns
    SELECT COUNT(*) AS TotalReturns
    FROM Loan L
    JOIN Books B ON L.Book_ID = B.Book_ID
    WHERE B.Library_ID = @LibraryID
      AND L.ReturnDate IS NOT NULL
      AND MONTH(L.ReturnDate) = @Month
      AND YEAR(L.ReturnDate) = @Year;

                                        --Revenues
    SELECT SUM(P.Amount) AS TotalRevenue
    FROM Payment P
    JOIN Loan L ON P.Loan_ID = L.Loan_ID
    JOIN Books B ON L.Book_ID = B.Book_ID
    WHERE B.Library_ID = @LibraryID
      AND MONTH(P.Payment_Date) = @Month
      AND YEAR(P.Payment_Date) = @Year;

                                        -- loan of 
    SELECT TOP 1 Book_Genre, COUNT(*) AS BorrowCount
    FROM Loan L
    JOIN Books B ON L.Book_ID = B.Book_ID
    WHERE B.Library_ID = @LibraryID
    GROUP BY Book_Genre
    ORDER BY BorrowCount DESC;

                                     -- member top 3
    SELECT TOP 3 M.Member_FullName, COUNT(*) AS LoanCount
    FROM Loan L
    JOIN Members M ON L.Member_ID = M.Member_ID
    JOIN Books B ON L.Book_ID = B.Book_ID
    WHERE B.Library_ID = @LibraryID
    GROUP BY M.Member_FullName
    ORDER BY LoanCount DESC;
END

EXEC sp_MonthlyLibraryReport 
    @LibraryID = 1,
    @Month = 3,
    @Year = 2024


SELECT COUNT(*) AS TotalLoans        ---- Total loans issued
FROM Loan L
JOIN Books B ON L.Book_ID = B.Book_ID
WHERE B.Library_ID = 1
  AND MONTH(L.LoanDate) = 3
  AND YEAR(L.LoanDate) = 2024


  SELECT TOP 1 B.Book_Genre, COUNT(*) AS BorrowCount  --- Most borrowed genre
FROM Loan L
JOIN Books B ON L.Book_ID = B.Book_ID
WHERE B.Library_ID = 1
GROUP BY B.Book_Genre
ORDER BY BorrowCount DESC

SELECT TOP 3 M.Member_FullName, COUNT(*) AS LoanCount   --- Top 3 most active members
FROM Loan L
JOIN Members M ON L.Member_ID = M.Member_ID
JOIN Books B ON L.Book_ID = B.Book_ID
WHERE B.Library_ID = 1
GROUP BY M.Member_FullName
ORDER BY LoanCount DESC


---The monthly library report was validated by executing the procedure for different months and comparing each result
--set with equivalent aggregate queries.
---The outputs accurately reflected loan activity, returns, revenue, popular genres, and member activity.