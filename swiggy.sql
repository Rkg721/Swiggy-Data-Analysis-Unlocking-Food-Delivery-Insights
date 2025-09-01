-- Swiggy Analysis SQL (Structured Format)

DROP TABLE IF EXISTS Fact_Swiggy;

CREATE TABLE Fact_Swiggy (
    ID              BIGINT PRIMARY KEY,
    Area            TEXT,
    City            TEXT,
    Restaurant      TEXT,
    Price           DECIMAL(10,2),
    "Avg ratings"   DECIMAL(4,2),
    "Total ratings" INT,
    "Food type"     TEXT,
    Address         TEXT,
    "Delivery time" INT
);

-- ==================================================
-- Question: Which are the top-rated restaurants with at least 100 reviews?
-- Script:
SELECT
  Restaurant, City, Area, "Avg ratings"
FROM Fact_Swiggy
WHERE "Total ratings" > 100
ORDER BY "Avg ratings" DESC
LIMIT 10;
-- Remarks: Filters restaurants with sufficient reviews and orders them by rating.
-- Conclusion: These restaurants stand out in quality and can be promoted as benchmarks.

-- ==================================================
-- Question: Which restaurants have the most customer engagement?
-- Script:
SELECT
  Restaurant, City, "Total ratings"
FROM Fact_Swiggy
ORDER BY "Total ratings" DESC
LIMIT 10;
-- Remarks: Ranks restaurants by total ratings (proxy for engagement).
-- Conclusion: Identifies venues with the largest customer bases and repeat usage.

-- ==================================================
-- Question: What is the average price per city?
-- Script:
SELECT
  City,
  AVG(Price) AS Average_Price
FROM Fact_Swiggy
GROUP BY City
ORDER BY Average_Price DESC;
-- Remarks: Calculates mean pricing across cities.
-- Conclusion: Helps benchmark affordability vs. premium positioning.

-- ==================================================
-- Question: How many restaurants are listed per city?
-- Script:
SELECT
  City,
  COUNT(DISTINCT Restaurant) AS Total_Restaurants
FROM Fact_Swiggy
GROUP BY City
ORDER BY Total_Restaurants DESC;
-- Remarks: Counts unique restaurants in each city.
-- Conclusion: Highlights geographic density and penetration.

-- ==================================================
-- Question: Which are the most expensive restaurants overall?
-- Script:
SELECT
  Restaurant, City, Price
FROM Fact_Swiggy
ORDER BY Price DESC
LIMIT 5;
-- Remarks: Lists restaurants with the highest listed prices.
-- Conclusion: These represent premium dining or niche market positioning.

-- ==================================================
-- Question: Which food types are most common among restaurants?
-- Script:
SELECT
  TRIM(SUBSTR(T1.Food_Type, 1, INSTR(T1.Food_Type || ',', ',') - 1)) AS Food_Type,
  COUNT(T1.ID) AS Total_Restaurants
FROM (
  SELECT ID, "Food type" AS Food_Type
  FROM Fact_Swiggy
) AS T1
GROUP BY Food_Type
ORDER BY Total_Restaurants DESC
LIMIT 10;
-- Remarks: Extracts first cuisine from comma-separated list for frequency count.
-- Conclusion: Identifies cuisines dominating restaurant menus.

-- ==================================================
-- Question: Which restaurants have high ratings but slower delivery?
-- Script:
SELECT
  Restaurant, City, "Avg ratings", "Delivery time"
FROM Fact_Swiggy
WHERE "Avg ratings" >= 4.0 AND "Delivery time" > 60
ORDER BY "Avg ratings" DESC, "Delivery time" DESC
LIMIT 10;
-- Remarks: Filters restaurants with good ratings but high delivery times.
-- Conclusion: Useful to flag potential operational inefficiencies.

-- ==================================================
-- Question: What is the average delivery time by city?
-- Script:
SELECT
  City,
  AVG("Delivery time") AS Average_Delivery_Time_Minutes
FROM Fact_Swiggy
GROUP BY City
ORDER BY Average_Delivery_Time_Minutes ASC;
-- Remarks: Calculates city-level delivery performance.
-- Conclusion: Helps benchmark logistics speed across geographies.

-- ==================================================
-- Question: Which restaurants are hidden gems (high rating + moderate reviews)?
-- Script:
SELECT
  Restaurant, City, "Avg ratings", "Total ratings"
FROM Fact_Swiggy
WHERE "Total ratings" BETWEEN 500 AND 1000
  AND "Avg ratings" >= 4.5
ORDER BY "Avg ratings" DESC, "Total ratings" DESC
LIMIT 10;
-- Remarks: Captures restaurants with high quality but moderate engagement.
-- Conclusion: These venues can be targeted for visibility campaigns.

-- ==================================================
-- Question: Which is the most expensive restaurant in each city?
-- Script:
SELECT
  T1.City, T1.Restaurant, T1.Price
FROM Fact_Swiggy AS T1
JOIN (
  SELECT City, MAX(Price) AS Max_Price
  FROM Fact_Swiggy
  GROUP BY City
) AS T2
ON T1.City = T2.City AND T1.Price = T2.Max_Price
ORDER BY T1.Price DESC;
-- Remarks: Joins restaurants with city-level maximum prices.
-- Conclusion: Highlights premium options city by city.
