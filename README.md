# Soccer_Tickets_DB
Functional soccer ticket reservation database built with SQL. Includes fans, teams, players, matches, stadiums, seats, bookings, tickets, memberships, and referees. Demonstrates the 4 DNs through data definition, manipulation, retrieval, and normalization, with practical INSERT and retrieval queries.



⚽ Soccer Match Reservation System

A functional Soccer Match Reservation System developed as a database project for COSC3337 – Database Theory.

The system is designed to manage soccer matches, teams, players, referees, stadiums, seats, fans, memberships, bookings, and tickets. It uses a relational database structure with primary keys, foreign keys, constraints, indexes, joins, subqueries, window functions, transactions, updates, and deletes.

🗄️ Database Structure

The database contains the following main entities:

Memberships – Stores membership tiers and discount percentages.
Fans – Stores fan information and their membership.
Teams – Stores soccer teams and their number of players.
Players – Stores player information and their associated team.
Referees – Stores referee information and experience levels.
Stadiums – Stores stadium names, locations, and capacities.
Seats – Stores seat numbers and seat types.
Matches – Stores match dates, leagues, stadiums, referees, and ticket prices.
MatchParticipants – Associates teams with matches as Home or Away.
MatchResults – Stores match scores and completion status.
Bookings – Stores fan ticket reservations.
Tickets – Stores individual tickets, seats, matches, prices, and bookings.
🔑 Main Features
Relational database design with primary and foreign keys
Unique and CHECK constraints
Ticket and seat reservation management
Fan membership discounts
Soccer match and team management
Match results tracking
Multiple-table JOIN queries
Subqueries
Window functions
Aggregations
Transactions with COMMIT
UPDATE and DELETE operations
Indexing for match dates
