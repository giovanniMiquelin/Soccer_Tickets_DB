-- TERM PROJECT: SOCCER MATCH RESERVATION SYSTEM
-- COURSE: COSC3337/Database Theory
-- NAME:  Giovanni Bezzan Miquelin
-- TIME: 5:35h

CREATE DATABASE IF NOT EXISTS project;
USE project;

-- Table: Memberships
CREATE TABLE Memberships (
    MembershipID INT AUTO_INCREMENT,
    TierName VARCHAR(20) NOT NULL UNIQUE,
    DiscountPercent DECIMAL(3, 2) NOT NULL,
    
    PRIMARY KEY (MembershipID)
);

-- Table: Referees
CREATE TABLE Referees (
    RefereeID INT AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ExperienceLevel VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (RefereeID)
);

-- Table: Fans
CREATE TABLE Fans (
    FanID INT AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50) NOT NULL,
    Age INT,
    MembershipID INT NOT NULL,
    
    PRIMARY KEY (FanID),
    FOREIGN KEY (MembershipID) REFERENCES Memberships(MembershipID),
    CONSTRAINT chk_email_format CHECK (Email LIKE '%_@__%.__%')
);

-- Table: Stadiums
CREATE TABLE Stadiums (
    StadiumID INT AUTO_INCREMENT,
    StadiumName VARCHAR(100) NOT NULL UNIQUE,
    City VARCHAR(50) NOT NULL,
    TotalCapacity INT NOT NULL,
    
    PRIMARY KEY (StadiumID)
);

-- Table: Seats
CREATE TABLE Seats (
    SeatID INT AUTO_INCREMENT,
    SeatNumber VARCHAR(5) NOT NULL,
    SeatType VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (SeatID)
);

-- Table: Teams
CREATE TABLE Teams (
    TeamID INT AUTO_INCREMENT,
    TeamName VARCHAR(100) NOT NULL UNIQUE,
    AmountOfPlayers INT NOT NULL,
    
    PRIMARY KEY (TeamID)
);

-- Table: Players
CREATE TABLE Players (
    PlayerID INT AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Position VARCHAR(20) NOT NULL,
    TeamID INT NOT NULL,
    
    PRIMARY KEY (PlayerID),
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

-- Table: Matches
CREATE TABLE Matches (
    MatchID INT AUTO_INCREMENT,
    StadiumID INT NOT NULL,
    RefereeID INT NOT NULL,
    LeagueName VARCHAR(100) NOT NULL,
    MatchDate DATETIME NOT NULL,
    BaseTicketPrice DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (MatchID),
    FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID),
    FOREIGN KEY (RefereeID) REFERENCES Referees(RefereeID)
);

-- Table: MatchParticipants
CREATE TABLE MatchParticipants (
    MatchID INT NOT NULL,
    TeamID INT NOT NULL,
    Role VARCHAR(10) NOT NULL, 
    
    PRIMARY KEY (MatchID, TeamID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

-- Table: MatchResults 
CREATE TABLE MatchResults (
    ResultID INT AUTO_INCREMENT,
    MatchID INT NOT NULL UNIQUE,
    HomeTeamGoals INT NOT NULL,
    AwayTeamGoals INT NOT NULL,
    FinalScore VARCHAR(10) NOT NULL,
    IsCompleted BOOLEAN NOT NULL,

    PRIMARY KEY (ResultID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

-- Table: Bookings 
CREATE TABLE Bookings (
    BookingID VARCHAR(20) NOT NULL,
    FanID INT NOT NULL,
    BookingDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    TicketsAmount DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (BookingID),
    FOREIGN KEY (FanID) REFERENCES Fans(FanID)
);

-- Table: Tickets 
CREATE TABLE Tickets (
    TicketID VARCHAR(20) NOT NULL,
    BookingID VARCHAR(20) NOT NULL,
    MatchID INT NOT NULL,
    SeatID INT NOT NULL,
    TicketPrice DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (TicketID),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID),
    CONSTRAINT uc_match_seat UNIQUE (MatchID, SeatID)
);

-- Index 
CREATE INDEX idx_match_date ON Matches(MatchDate);

-- Inserts

INSERT INTO Memberships (MembershipID, TierName, DiscountPercent) VALUES 
(1, 'Gold', 0.20), 
(2, 'Silver', 0.10), 
(3, 'Standard', 0.00);

INSERT INTO Referees (RefereeID, FirstName, LastName, ExperienceLevel) VALUES 
(1, 'Pierluigi', 'Collina', 'International'), 
(2, 'Howard', 'Webb', 'Senior'),
(3, 'Sian', 'Massey', 'Junior'),
(4, 'Nestor', 'Pitana', 'International');

INSERT INTO Stadiums (StadiumID, StadiumName, City, TotalCapacity) VALUES 
(1, 'Wembley', 'London', 90000), 
(2, 'Camp Nou', 'Barcelona', 99000),
(3, 'Santiago Bernabeu', 'Madrid', 81000),
(4, 'Old Trafford', 'Manchester', 74000);

INSERT INTO Fans (FanID, FirstName, LastName, Email, Country, Age, MembershipID) VALUES 
(1, 'Alice', 'Smith', 'alice@email.com', 'USA', 28, 1), 
(2, 'Bob', 'Jones', 'bob@email.com', 'UK', 34, 2),
(3, 'Carlos', 'Ruiz', 'carlos@email.com', 'Spain', 21, 3),
(4, 'Diana', 'Prince', 'diana@email.com', 'USA', 45, 1),
(5, 'Enzo', 'Ferrari', 'enzo@email.com', 'Italy', 55, 1);

INSERT INTO Seats (SeatID, SeatNumber, SeatType) VALUES 
(1, '10', 'Box'), 
(2, '20', 'Bleacher'),
(3, '1', 'Box'),
(4, '50', 'Bleacher'),
(5, '2', 'Box'),
(6, '3', 'Box'),
(7, '10', 'Standard');

INSERT INTO Teams (TeamID, TeamName, AmountOfPlayers) VALUES 
(1, 'London Lions', 25), 
(2, 'Barcelona FC', 25),
(3, 'Madrid Royals', 25),
(4, 'Manchester Reds', 25);

INSERT INTO Players (PlayerID, FirstName, LastName, Position, TeamID) VALUES 
(1, 'Harry', 'Kane', 'Forward', 1), 
(2, 'Bukayo', 'Saka', 'Forward', 1),
(3, 'Lionel', 'Messi', 'Forward', 2),
(4, 'Xavi', 'Hernandez', 'Midfielder', 2),
(5, 'Andres', 'Iniesta', 'Midfielder', 2),
(6, 'Carles', 'Puyol', 'Defender', 2),
(7, 'Cristiano', 'Ronaldo', 'Forward', 3),
(8, 'Luka', 'Modric', 'Midfielder', 3),
(9, 'Sergio', 'Ramos', 'Defender', 3),
(10, 'Iker', 'Casillas', 'Keeper', 3),
(11, 'Wayne', 'Rooney', 'Forward', 4),
(12, 'Paul', 'Scholes', 'Midfielder', 4);

-- Matches Inserts
INSERT INTO Matches (MatchID, StadiumID, RefereeID, LeagueName, MatchDate, BaseTicketPrice) VALUES 
(101, 2, 1, 'Champions Cup', '2026-06-15 20:00:00', 250.00),
(102, 1, 2, 'Global Premier', '2026-06-20 18:00:00', 150.00),
(103, 3, 4, 'Champions Cup', '2026-07-01 21:00:00', 300.00);

-- MatchParticipants Inserts 
INSERT INTO MatchParticipants (MatchID, TeamID, Role) VALUES
(101, 2, 'Home'),
(101, 3, 'Away'),
(102, 1, 'Home'),
(102, 4, 'Away'),
(103, 3, 'Home'),
(103, 2, 'Away');

-- MatchResults Inserts 
INSERT INTO MatchResults (ResultID, MatchID, HomeTeamGoals, AwayTeamGoals, FinalScore, IsCompleted) VALUES 
(1, 101, 3, 2, '3-2', TRUE),
(2, 102, 1, 1, '1-1', TRUE),
(3, 103, 0, 0, 'TBD', FALSE);

-- Bookings Inserts (Now using VARCHAR strings!)
INSERT INTO Bookings (BookingID, FanID, BookingDate, TicketsAmount) VALUES 
('BKG-501', 1, '2026-05-01 10:00:00', 250.00),
('BKG-502', 2, '2026-05-02 11:30:00', 150.00),
('BKG-503', 3, '2026-05-10 09:00:00', 550.00);

-- Tickets Inserts (Now using VARCHAR strings!)
INSERT INTO Tickets (TicketID, BookingID, MatchID, SeatID, TicketPrice) VALUES 
('TKT-1001', 'BKG-501', 101, 3, 250.00), 
('TKT-1002', 'BKG-502', 102, 2, 150.00), 
('TKT-1003', 'BKG-503', 103, 5, 300.00), 
('TKT-1004', 'BKG-503', 101, 4, 250.00);


--                 QUERIES:

-- Query 1: MULTIPLE JOINS
SELECT f.FirstName, f.LastName, m.MatchDate, s.StadiumName, st.SeatNumber, t.TicketPrice
FROM Tickets t
JOIN Bookings b ON t.BookingID = b.BookingID
JOIN Fans f ON b.FanID = f.FanID
JOIN Matches m ON t.MatchID = m.MatchID
JOIN Stadiums s ON m.StadiumID = s.StadiumID
JOIN Seats st ON t.SeatID = st.SeatID;

-- Query 2: SUBQUERY 
SELECT FirstName, LastName, Position 
FROM Players 
WHERE TeamID IN (
    SELECT 
        CASE 
            WHEN mr.HomeTeamGoals > mr.AwayTeamGoals THEN mp_home.TeamID
            WHEN mr.AwayTeamGoals > mr.HomeTeamGoals THEN mp_away.TeamID
        END
    FROM MatchResults mr
    JOIN MatchParticipants mp_home ON mr.MatchID = mp_home.MatchID AND mp_home.Role = 'Home'
    JOIN MatchParticipants mp_away ON mr.MatchID = mp_away.MatchID AND mp_away.Role = 'Away'
    WHERE mr.IsCompleted = TRUE AND mr.HomeTeamGoals != mr.AwayTeamGoals
);

-- Query 3: WINDOW FUNCTION
SELECT f.FanID, f.FirstName, f.Country, SUM(b.TicketsAmount) as TotalSpent,
       RANK() OVER (PARTITION BY f.Country ORDER BY SUM(b.TicketsAmount) DESC) as SpendingRank
FROM Fans f
JOIN Bookings b ON f.FanID = b.FanID
GROUP BY f.FanID, f.FirstName, f.Country;

-- Query 4: TRANSACTION (Updated for VARCHAR IDs)
START TRANSACTION;
INSERT INTO Bookings (BookingID, FanID, BookingDate, TicketsAmount) 
VALUES ('BKG-504', 3, CURRENT_TIMESTAMP, 150.00);

INSERT INTO Tickets (TicketID, BookingID, MatchID, SeatID, TicketPrice) 
VALUES ('TKT-1005', 'BKG-504', 102, 1, 150.00);
COMMIT;

-- Query 5: UPDATE WITH SUBQUERY
UPDATE Matches 
SET BaseTicketPrice = BaseTicketPrice * 1.15 
WHERE StadiumID IN (
    SELECT StadiumID 
    FROM Stadiums 
    WHERE City = 'London'
);

-- Query 6: DELETE WITH SUBQUERY
DELETE FROM Seats 
WHERE SeatType = 'Bleacher' 
  AND SeatID NOT IN (
      SELECT SeatID 
      FROM Tickets
  );

-- Query 7: JOIN 
SELECT s.StadiumName, SUM(t.TicketPrice) as TotalRevenue 
FROM Tickets t
JOIN Matches m ON t.MatchID = m.MatchID
JOIN Stadiums s ON m.StadiumID = s.StadiumID
GROUP BY s.StadiumName
ORDER BY TotalRevenue DESC;

-- Query 8: SUBQUERY 
SELECT FanID, FirstName, LastName, Email 
FROM Fans 
WHERE FanID NOT IN (
    SELECT DISTINCT FanID 
    FROM Bookings
);

-- Query 9: WINDOW FUNCTION 
SELECT t.TicketID, b.BookingDate, t.TicketPrice, 
       SUM(t.TicketPrice) OVER (PARTITION BY t.MatchID ORDER BY b.BookingDate) as RunningMatchRevenue
FROM Tickets t
JOIN Bookings b ON t.BookingID = b.BookingID
WHERE t.MatchID = 101;

-- Query 10: COMPLEX JOIN 
SELECT m.MatchDate as GameTime, t1.TeamName as HomeTeam, t2.TeamName as AwayTeam, mr.FinalScore 
FROM MatchResults mr
JOIN Matches m ON mr.MatchID = m.MatchID
JOIN MatchParticipants mp1 ON m.MatchID = mp1.MatchID AND mp1.Role = 'Home'
JOIN Teams t1 ON mp1.TeamID = t1.TeamID
JOIN MatchParticipants mp2 ON m.MatchID = mp2.MatchID AND mp2.Role = 'Away'
JOIN Teams t2 ON mp2.TeamID = t2.TeamID
WHERE mr.IsCompleted = TRUE;

-- Query 11: UPDATE
UPDATE Bookings b
JOIN Fans f ON b.FanID = f.FanID
JOIN Memberships m ON f.MembershipID = m.MembershipID
SET b.TicketsAmount = (
    SELECT SUM(TicketPrice) 
    FROM Tickets t 
    WHERE t.BookingID = b.BookingID
) * (1 - m.DiscountPercent)
WHERE b.BookingID IN (SELECT DISTINCT BookingID FROM Tickets);

-- Query 12: TRANSACTION (Updated for VARCHAR IDs)
START TRANSACTION;
DELETE FROM Tickets WHERE BookingID = 'BKG-503';
DELETE FROM Bookings WHERE BookingID = 'BKG-503';
COMMIT;

-- ==========================================
-- Queries used in the Presentation
-- ==========================================

-- Query 13: SPECIFIC JOIN
SELECT p.FirstName, p.LastName, p.Position, t.TeamName
FROM Players p
JOIN Teams t ON p.TeamID = t.TeamID
WHERE t.TeamID = (
    SELECT 
        CASE 
            WHEN mr.HomeTeamGoals > mr.AwayTeamGoals THEN mp_home.TeamID
            WHEN mr.AwayTeamGoals > mr.HomeTeamGoals THEN mp_away.TeamID
        END
    FROM MatchResults mr
    JOIN MatchParticipants mp_home ON mr.MatchID = mp_home.MatchID AND mp_home.Role = 'Home'
    JOIN MatchParticipants mp_away ON mr.MatchID = mp_away.MatchID AND mp_away.Role = 'Away'
    WHERE mr.MatchID = 101
);

-- Query 14: MULTIPLE JOINS
SELECT m.MatchDate, s.StadiumName, t1.TeamName AS HomeTeam, t2.TeamName AS AwayTeam
FROM Matches m
JOIN Stadiums s ON m.StadiumID = s.StadiumID
JOIN MatchParticipants mp1 ON m.MatchID = mp1.MatchID AND mp1.Role = 'Home'
JOIN Teams t1 ON mp1.TeamID = t1.TeamID
JOIN MatchParticipants mp2 ON m.MatchID = mp2.MatchID AND mp2.Role = 'Away'
JOIN Teams t2 ON mp2.TeamID = t2.TeamID
ORDER BY m.MatchDate ASC;

-- Query 15: COMPLEX JOIN & AGGREGATION
SELECT mem.TierName, SUM(t.TicketPrice) AS TotalRevenue
FROM Tickets t
JOIN Bookings b ON t.BookingID = b.BookingID
JOIN Fans f ON b.FanID = f.FanID
JOIN Memberships mem ON f.MembershipID = mem.MembershipID
GROUP BY mem.TierName;

-- Query 16: JOIN WITH COUNT
SELECT r.FirstName, r.LastName, COUNT(m.MatchID) AS MatchesOfficiated
FROM Referees r
JOIN Matches m ON r.RefereeID = m.RefereeID
GROUP BY r.RefereeID, r.FirstName, r.LastName
ORDER BY MatchesOfficiated DESC;

-- Query 17: AGGREGATION
SELECT SUM(TotalCapacity) AS GlobalSeatingCapacity
FROM Stadiums;