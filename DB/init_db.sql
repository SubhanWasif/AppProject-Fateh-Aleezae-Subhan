USE master;
GO

-- Drop the database if it exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Restuarant')
BEGIN
    ALTER DATABASE Restuarant SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Restuarant;
END;

-- Create the database
CREATE DATABASE Restuarant;
GO

USE Restuarant;
GO

-- Create the USERS table
CREATE TABLE USERS(
   USER_ID       INT NOT NULL PRIMARY KEY,
   FIRST_NAME    VARCHAR (20) NOT NULL,
   LAST_NAME     VARCHAR (20) NOT NULL,
   EMAIL         VARCHAR  (25),
   PHONE         VARCHAR (15)  NOT NULL
);

-- Create the ORDERS table
CREATE TABLE ORDERS(
   ORDER_ID      INT NOT NULL PRIMARY KEY,
   USER_ID       INT NOT NULL,
   ORDER_DATE    DATE NOT NULL,
   ORDER_TIME    TIME NOT NULL,
   ORDER_STATUS  VARCHAR (20) NOT NULL,
   ORDER_TOTAL   DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);
-- Create the MENU_ITEM table
CREATE TABLE MENU_ITEM(
   ITEM_ID       INT NOT NULL PRIMARY KEY,
   ITEM_NAME     VARCHAR (20) NOT NULL,
   ITEM_PRICE    DECIMAL(10, 2) NOT NULL,
   ITEM_CATEGORY VARCHAR (20) NOT NULL,
   ITEM_DESC     VARCHAR (100) NOT NULL,
   ITEM_IMAGE    VARCHAR (100) NOT NULL,
   ITEM_STATUS   VARCHAR (20) NOT NULL
);

-- Create the ORDER_ITEM table
CREATE TABLE ORDER_ITEM(
   ORDER_ID      INT NOT NULL,
   ITEM_ID       INT NOT NULL PRIMARY KEY,
   ITEM_QUANTITY INT NOT NULL,
   ITEM_PRICE    DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
   FOREIGN KEY (ITEM_ID) REFERENCES MENU_ITEM(ITEM_ID)
);

-- Create the RESERVATION table
CREATE TABLE RESERVATION(
   RESERVATION_ID INT PRIMARY KEY,
   ORDER_ID        INT NOT NULL,
   RESERVATION_DATE DATE NOT NULL,
   RESERVATION_TIME TIME NOT NULL,
   RESERVATION_STATUS VARCHAR (20) NOT NULL,
   RESERVATION_TOTAL DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

-- Create the PRIVATE_BOOKING table
CREATE TABLE PRIVATE_BOOKING(
   BOOKING_ID      INT PRIMARY KEY,
   ORDER_ID        INT NOT NULL,
   BOOKING_DATE    DATE NOT NULL,
   BOOKING_TIME    TIME NOT NULL,
   BOOKING_STATUS  VARCHAR (20) NOT NULL,
   BOOKING_TOTAL   DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
   FOREIGN KEY (BOOKING_ID) REFERENCES RESERVATION(RESERVATION_ID)
);


-- Inserting into USERS
INSERT INTO USERS (USER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '1234567890'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '0987654321');

-- Inserting into MENU_ITEM
INSERT INTO MENU_ITEM (ITEM_ID, ITEM_NAME, ITEM_PRICE, ITEM_CATEGORY, ITEM_DESC, ITEM_IMAGE, ITEM_STATUS) VALUES
(1, 'Cheese Pizza', 7.99, 'Main', 'Pizza', 'cheesepizza.jpg', 'Available'),
(2, 'Veggie Burger', 5.99, 'Main', 'Burger', 'veggieburger.jpg', 'Available'),
(3, 'beef Burger', 9.99, 'Main', 'Burger', 'beefburger.jpg', 'Available');

-- Inserting into ORDERS
INSERT INTO ORDERS (ORDER_ID, USER_ID, ORDER_DATE, ORDER_TIME, ORDER_STATUS, ORDER_TOTAL) VALUES
(1, 1, '2023-12-24', '18:00:00', 'Confirmed', 13.98),
(2, 2, '2023-12-25', '19:00:00', 'Confirmed', 5.99),
(3, 1, '2023-10-22', '11:30:30', 'Confirmed', 15.98);

-- Inserting into ORDER_ITEM
INSERT INTO ORDER_ITEM (ORDER_ID, ITEM_ID, ITEM_QUANTITY, ITEM_PRICE) VALUES
(1, 1, 1, 7.99),
(2, 2, 1, 5.99),
(3, 3, 1, 5.99);

-- Inserting into RESERVATION
INSERT INTO RESERVATION (RESERVATION_ID, ORDER_ID, RESERVATION_DATE, RESERVATION_TIME, RESERVATION_STATUS, RESERVATION_TOTAL) VALUES
(1, 1, '2023-12-24', '20:00:00', 'Reserved', 20.00),
(2, 2, '2023-11-20', '20:30:00', 'Reserved', 30.00);

-- Inserting into PRIVATE_BOOKING
INSERT INTO PRIVATE_BOOKING (BOOKING_ID, ORDER_ID, BOOKING_DATE, BOOKING_TIME, BOOKING_STATUS, BOOKING_TOTAL) VALUES
(1, 1, '2023-12-31', '21:00:10', 'Booked', 100.00),
(2, 2, '2023-12-30', '11:30:00', 'Booked', 150.00);
/*
SELECT * FROM USERS;
SELECT * FROM ORDERS;
SELECT * FROM MENU_ITEM;
SELECT * FROM ORDER_ITEM;
SELECT * FROM RESERVATION;
SELECT * FROM PRIVATE_BOOKING;
*/
