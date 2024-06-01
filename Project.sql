-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS AirBnB_NYC;

-- Switch to the new database
USE AirBnB_NYC;

-- Drop and create the Hosts table
DROP TABLE IF EXISTS Hosts;
CREATE TABLE Hosts (
    host_id INT PRIMARY KEY,
    host_name VARCHAR(255),
    calculated_host_listings_count INT
);

-- Drop and create the Listings table
DROP TABLE IF EXISTS Listings;
CREATE TABLE Listings (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    host_id INT,
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    room_type VARCHAR(255),
    price INT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month FLOAT,
    calculated_host_listings_count INT,
    availability_365 INT,
    FOREIGN KEY (host_id) REFERENCES Hosts(host_id)
);

-- Drop and create the Reviews table
DROP TABLE IF EXISTS Reviews;
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT,
    review_date DATE,
    reviews_per_month FLOAT,
    FOREIGN KEY (listing_id) REFERENCES Listings(id)
);

DESCRIBE hosts;
DESCRIBE listings;
DESCRIBE reviews;

-- Create a new table to store the joined data
DROP TABLE IF EXISTS AirBnB_clean;

CREATE TABLE AirBnB_clean AS
SELECT h.host_id, h.host_name, h.calculated_host_listings_count,
       l.id, l.name, l.neighbourhood_group, l.neighbourhood, l.latitude, l.longitude, l.room_type, l.price, l.minimum_nights, l.number_of_reviews, l.last_review, l.availability_365,
       r.review_id, r.listing_id, r.review_date, r.reviews_per_month
FROM Hosts AS h
INNER JOIN Listings AS l ON h.host_id = l.host_id
INNER JOIN Reviews AS r ON l.id = r.listing_id
WHERE 
    h.host_id IS NOT NULL AND
    h.host_name IS NOT NULL AND
    h.calculated_host_listings_count IS NOT NULL AND
    l.id IS NOT NULL AND
    l.name IS NOT NULL AND
    l.neighbourhood_group IS NOT NULL AND
    l.neighbourhood IS NOT NULL AND
    l.latitude IS NOT NULL AND
    l.longitude IS NOT NULL AND
    l.room_type IS NOT NULL AND
    l.price IS NOT NULL AND
    l.minimum_nights IS NOT NULL AND
    l.number_of_reviews IS NOT NULL AND
    l.last_review IS NOT NULL AND
    l.availability_365 IS NOT NULL AND
    r.review_id IS NOT NULL AND
    r.listing_id IS NOT NULL AND
    r.review_date IS NOT NULL AND
    r.reviews_per_month IS NOT NULL;

DESCRIBE AirBnB_clean;