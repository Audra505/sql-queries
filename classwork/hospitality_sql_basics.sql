---Create A Database Hospotality
CREATE DATABASE Hospitality

USE Hospitality

SELECT  DISTINCT booking_channel
FROM             Hospitality

SELECT *
FROM         Hospitality
WHERE        booking_channel = 'Call Center'


---- Class Work -
/*Can you pull the list of reservation made between June 1st, 2020 and August 31st, 2020 that was completed and extended 
and the Room type is Double*/

SELECT * 
FROM             Hospitality
WHERE            Date >= '2020-06-01' AND Date <= '2020-08-31'
AND              reservation_status IN ('Completed', 'Extended')
AND              room_type = 'Double'

-----LIKE OPERATOR
SELECT * 
FROM             Hospitality
WHERE            room_type LIKE '%uite%'

SELECT * 
FROM             Hospitality
WHERE            booking_channel LIKE '%App'

----GROUP BY CLAUSE
SELECT           booking_channel, COUNT(reservation_id) AS 'Total Reservation'
FROM             Hospitality
GROUP BY         booking_channel


USE Hospitality

SELECT * 
FROM             Hospitality

----- Continuation of GROUP BY Clause
----- Classwork:Show the number of Reservations on a Daily Basis

SELECT      CONVERT(DATE, check_in_date) Date, COUNT(reservation_id) AS 'Total Reservation'
FROM        Hospitality
GROUP BY    check_in_date
ORDER BY    check_in_date

--- AGGREGATE Function
----- Classwork: Group Our Total Reservation, Our Shortest Stay, Longest Stay, Average Stay and Total Adults by Room Type

SELECT room_type,
       COUNT(reservation_id) AS 'Total Reservation',
	   MIN(stay_duration) AS 'Shortest Stay',
	   MAX(stay_duration) AS 'Longest Stay',
	   AVG(stay_duration) AS 'Average Stay',
	   SUM(adults) AS 'Total Adults'
FROM   Hospitality
GROUP BY room_type

----- Classwork: Group Our Total Reservation, Our Shortest Stay, Longest Stay, Average Stay and Total Adults by Room Type when the reservation is extended

SELECT room_type,
       COUNT(reservation_id) AS 'Total Reservation',
	   MIN(stay_duration) AS 'Shortest Stay',
	   MAX(stay_duration) AS 'Longest Stay',
	   AVG(stay_duration) AS 'Average Stay',
	   SUM(adults) AS 'Total Adults'
FROM   Hospitality WHERE reservation_status = 'Extended'
GROUP BY room_type

----CLasswork on AGGREGATE Function
/* I am curious to know which of our properties drives the most completed and extended reservation and longest stay of client*/

SELECT Property,
       COUNT(reservation_id) AS 'Total Reservation',
	   MAX(stay_duration) AS 'Stay Duration',
	   SUM(adults) AS 'Total Adults'
FROM   Hospitality WHERE reservation_status IN('Completed', 'Extended')
GROUP BY Property;

-----HAVING CLAUSE
-----CLasswork: Show us Room Type where Total Reservation is greater than 15000

SELECT room_type, COUNT(reservation_id) TotalReservation
FROM   Hospitality
GROUP BY room_type
HAVING COUNT(reservation_id) > 15000

-- HAVING Classwork
/*I would like to talk to our Properties Managers that their property is having less completed reservation to understand if 
there is something we could be doing better. Kindly pull a list of Properties with less than 20,000 completed and extended reservation*/

SELECT Property, COUNT(reservation_id) TotalReservation
FROM   Hospitality WHERE reservation_status IN('Completed', 'Extended')
GROUP BY Property
HAVING COUNT(reservation_id) < 20000


----ORDER BY CLAUSE
SELECT      CONVERT(DATE, check_in_date) Date, COUNT(reservation_id) AS 'Total Reservation'
FROM        Hospitality
GROUP BY    check_in_date
ORDER BY    check_in_date DESC

--Class work on Order By Clause
/*I would like to see the list of our booking_channel with number of reservation
sorting from the Most used channel to the lesser channel */

SELECT         booking_channel, COUNT(reservation_id) TotalReservation
FROM           Hospitality               
GROUP BY       booking_channel
ORDER BY       COUNT(reservation_id) DESC


/*I would like to see the list of our booking_channel with number of reservation
sorting from the Most used channel to the lesser channel and amount of money from each booking channel */

SELECT         booking_channel, 
               COUNT(reservation_id) TotalReservation,
			   CONCAT('$', CONVERT(MONEY, SUM(Avg_Room_Rate))) TotalRoomRate
FROM           Hospitality               
GROUP BY       booking_channel
ORDER BY       COUNT(reservation_id) DESC


----- CASE STATEMENTS
SELECT      Avg_Room_rate, reservation_id, room_type, property, 
            CASE 
			    WHEN stay_duration <= 7 THEN 'Under One Week'
				WHEN stay_duration > 7 THEN 'Within Two Weeks'
				ELSE 'Check Logic'
				END AS 'Stay Duration Category'
FROM        Hospitality
ORDER BY    5


----Using WHERE CLAUSE
SELECT      Avg_Room_rate, reservation_id, room_type, property, 
            CASE 
			    WHEN stay_duration <= 7 THEN 'Under One Week'
				WHEN stay_duration > 7 THEN 'Within Two Weeks'
				ELSE 'Check Logic'
				END AS 'Stay Duration Category'
FROM        Hospitality
WHERE         CASE 
			    WHEN stay_duration <= 7 THEN 'Under One Week'
				WHEN stay_duration > 7 THEN 'Within Two Weeks'
				ELSE 'Check Logic'
				END = 'Under One Week'

----Another Example 
SELECT		reservation_id, avg_room_rate, room_type, booking_channel, property,
			CASE
				WHEN avg_room_rate <= 150 THEN 'Cheap Rate'
				WHEN avg_room_rate BETWEEN 150 AND 200 THEN 'Affordable Rate'
				ELSE 'Expensive Rate'
			END AS Pricing
FROM        Hospitality
ORDER BY    2 DESC

----Example when Grouping Things 
SELECT		reservation_id, avg_room_rate, room_type, property,
			CASE
				WHEN avg_room_rate <= 150 THEN 'Cheap Rate'
				WHEN avg_room_rate BETWEEN 150 AND 200 THEN 'Affordable Rate'
				ELSE 'Expensive Rate'
			END AS Pricing,
			CASE
				WHEN room_type IN ('Single', 'Double') THEN 'Individual'
				WHEN room_type IN ('King', 'Queen') THEN 'Family'
				WHEN room_type IN ('Suite', 'Executive Suite') THEN 'Corporate and Business'
				ELSE 'Oops .... check logic'
			END AS 'Room Category'
FROM        Hospitality
ORDER BY    2 DESC


			
FROM		Hospitality
ORDER BY	2 DESC





SELECT		reservation_id, avg_room_rate, room_type, property,
			CASE
				WHEN avg_room_rate <= 150 THEN 'Cheap Rate'
				WHEN avg_room_rate BETWEEN 150 AND 200 THEN 'Affordable Rate'
				ELSE 'Expensive Rate'
			END AS Pricing,
			CASE
				WHEN room_type IN ('Single', 'Double') THEN 'Individual'
				WHEN room_type IN ('King', 'Queen') THEN 'Family'
				WHEN room_type IN ('Suite', 'Executive Suite') THEN 'Corporate and Business'
				ELSE 'Oops .... check logic'
			END AS 'Room Category'
FROM		Hospitality
ORDER BY	2 DESC


----Classwork on CASE Statement
-- I would like to know which Property each reservation is done and whether the reservation is completed or not. 
--Could you pull a list of reservation_id,
--and label them as 'Property Name - Reservation_status'

SELECT		reservation_id
			, CASE
					WHEN reservation_status = 'Completed' THEN CONCAT(Property, ' - ', reservation_status)
					WHEN reservation_status = 'Extended' THEN CONCAT(Property, ' - ', reservation_status)
					WHEN reservation_status = 'No-Show' THEN CONCAT(Property, ' - ', reservation_status)
					WHEN reservation_status = 'Reduced' THEN CONCAT(Property, ' - ', reservation_status)
				ELSE 'Check Logic...'
				END		AS 'Property & Status'	
			, CASE
					WHEN reservation_status = 'Completed' THEN 2
					WHEN reservation_status = 'Extended' THEN 1
					WHEN reservation_status = 'No-Show' THEN 4
					WHEN reservation_status = 'Reduced' THEN 3
				ELSE 'Check Logic...'
				END		AS 'Order'		
FROM		Hospitality
ORDER BY	3, Property 
