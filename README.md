# Google Capstone Project Bike-Share
First track of Google Capstone Project part of  Google Data Analytics Professional Certificate
# **> Project Still in Progress <** 
# Deliverables
- [x] A clear statement of the business task
- [x] A description of all data sources used
- [ ] Documentation of any cleaning or manipulation of data
- [ ] A summary of your analysis
- [ ] Supporting visualizations and key findings
- [ ] Your top three recommendations based on your analysis

# Table of content
- [Overview](#Overview)
    - [Introduction](#Introduction)
    - [Goal](#Goal)
    - [My Job](#My-job)
- [Analysis Process](#Analysis-Process)
    - [Ask](#Ask)
       - [Business Statement](#Business-Statement)
       - [Stakeholders](#Stakeholders)
    - [Prepare](#Prepare)
    - [Process](#Process)
       - [Data Cleaning](#Data-Cleaning)
    - [Analyze](#Analyze)
    - [Share](#Share)
    - [Act](#Act)


# Overview 
### Introduction
Cyclists is a fictional company launched in 2016, it has: 
- 5824 bicycles geo-tracked and locked into a network of 692 docking stations across Chicago.
- The bikes can be unlocked from one station and returned to any other station in the system at any time.
- Bike types: 
    - Standard two-wheeled bikes
    - Reclining bikes
    - Hand tricycles
    - Cargo bikes
- 8% of riders use the assistive options, and 92% use the Standard two-wheeled bikes.
- Users are more likely to ride for leisure, but 30% use them to commute to work every day.
- Pricing planes: 
   - single-ride passes "Casual rider"
   - full-day passes "Casual rider"
   - annual memberships > More Profitable 

### Goal
Maximize the number of Annual Memberships.
### My job
Understanding how casual riders & annual members use Cylistic bikes differently, enhances the chance of converting casual riders into annual members. 

# Analysis Process
## Ask
### The problem I'm trying to solve
 Understanding how casual riders differ from annual members to sway them to become members to increase future growth.
### How can my insights drive business decisions?
The findings and insights gained from analyzing how annual members and casual riders use Cylistic differently will assist the team in coming up with recommendations for growing the annual membership and thus, the company's profit. 

### Business Statement
Understanding the different behaviors of casual riders and annual members, to encourage casual riders to be members of the Cylistic. 
### Stakeholders: 
- The Director of Marketing (Lily Moreno)
- Marketing Analytics team
- Executive team

## Prepare
### Description of the used datasets
Source | [Cyclistic trip data](https://divvy-tripdata.s3.amazonaws.com/index.html)
| :--- | :---
Publisher | Motivate International Inc.
Dataset  | 202301-divvy-tripdata to 202304-divvy-tripdata
Timespan | First Quarter of 2023

Attribute name | Attribute Description | Example
| :--- | :--- | :--- 
ride_id | A unique ID for each ride | 9CA8DA324B4C8DFC
rideable_type | This attribute shows the bike type (electric_bike, classic_bike, docked_bike) | classic_bike
started_at | This attribute shows the start date and time of the ride | 28/06/2023  16:25:27 
ended_at | This attribute shows the end date and time of the ride | 21/06/2023  16:31:55 
start_station_name | This attribute shows the name of the start station | Sedgwick St & Huron St
start_station_id | This attribute shows the ID of the start station | TA1307000062
end_station_name | This attribute shows the name of the end station | Canal St & Monroe St
end_station_id | This attribute shows the ID of the end station | 13056
start_lat | This attribute shows the start latitude of the ride | 41.894666
start_lng | This attribute shows the start longitude of the ride | -87.638437
end_lat | This attribute shows the end latitude of the ride | 41.88169
end_lng | This attribute shows the end longitude of the ride | -87.63953
member_casual |This attribute shows the Member or Casual rider | member

## Process
### Tool
I'm using SQL for this phase; because the dataset is too big to handle with spreadsheet software.
### Data Cleaning 
#### Checklist:
- [x] Dataset size -> 1065153 rows
- [x] Adding additional attributes -> 1. Month, 2.  Day of the Week, 3. Ride Length
- [x] Incorrect data 
- [ ] Missing values 
- [ ] Duplicate 

#### Code
```
# Create a new table with bike usage data for the first quarter of 2023
DROP TABLE IF EXISTS bike_q1;
CREATE TABLE bike_q1 AS 
(
SELECT  `ride_id`,
`rideable_type`,
`started_at`,
`ended_at`,
 TIMEDIFF(ended_at, started_at) AS ride_duration, 
 MONTH(started_at) AS month,
 DAYNAME(started_at) AS day_of_week,
`start_station_name`,
`start_station_id`,
`end_station_name`,
`end_station_id`,
`start_lat`,
`start_lng`,
`end_lat`,
`end_lng`,
`member_casual`
FROM january
) 
UNION ALL
(
SELECT  `ride_id`,
`rideable_type`,
`started_at`,
`ended_at`,
 TIMEDIFF(ended_at, started_at) AS ride_duration, 
 MONTH(started_at) AS month,
 DAYNAME(started_at) AS day_of_week,
`start_station_name`,
`start_station_id`,
`end_station_name`,
`end_station_id`,
`start_lat`,
`start_lng`,
`end_lat`,
`end_lng`,
`member_casual`
FROM february
)
UNION ALL
(
SELECT  `ride_id`,
`rideable_type`,
`started_at`,
`ended_at`,
 TIMEDIFF(ended_at, started_at) AS ride_duration, 
 MONTH(started_at) AS month,
 DAYNAME(started_at) AS day_of_week,
`start_station_name`,
`start_station_id`,
`end_station_name`,
`end_station_id`,
`start_lat`,
`start_lng`,
`end_lat`,
`end_lng`,
`member_casual`
FROM march
)
UNION ALL
(
SELECT  `ride_id`,
`rideable_type`,
`started_at`,
`ended_at`,
 TIMEDIFF(ended_at, started_at) AS ride_duration, 
 MONTH(started_at) AS month,
 DAYNAME(started_at) AS day_of_week,
`start_station_name`,
`start_station_id`,
`end_station_name`,
`end_station_id`,
`start_lat`,
`start_lng`,
`end_lat`,
`end_lng`,
`member_casual`
FROM april
);
```
```
# Eleminate data with ride duration < 1 minute => result of deleting 72 rows
SELECT *
FROM bike_q1
WHERE ride_duration < 1;

DELETE FROM bike_q1
WHERE ride_duration < 1;
```


## Analyze

## Share

## Act



