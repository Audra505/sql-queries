USE Hospitality

SELECT *
FROM   Hospitality

-----Using the Hospitality Database. Answer the following Business Questions:

/* 1. I need to get a quick overview of how long (Average Days) our room are being reserved for by room type. */
SELECT   room_type, COUNT(reservation_id) TotalReservation,
         AVG(stay_duration) AS 'Avergae Stay',
		 MAX(stay_duration) AS 'Longest Stay'
FROM     Hospitality
GROUP BY room_type;    


/* 2. Give a list of reservations that are neither completed nor extended. */
SELECT reservation_status
FROM   Hospitality

SELECT		*
FROM		Hospitality
WHERE reservation_status NOT IN('Completed','Extended');


/* 3. I am curious to know which of our properties drives the most reservation? */
SELECT   Property, COUNT(reservation_id) TotalReservation
FROM     Hospitality 
GROUP BY Property
ORDER BY  2 DESC


/* 4. Give us a list of reservation where the check in date is in the summer (June to August) 
or the Property ends with “key” AND room type is King and Queen. */
SELECT			*
FROM			Hospitality
WHERE    check_in_date >= '2020-06-01' AND check_in_date <= '2020-08-31'
OR       Property LIKE  '%key'
AND      room_type IN('King', 'Queen');


/* 5. Our customers want to know the room option we have, considering the rate. Can you pull a list of room types we have available and their Average Rate.*/
SELECT     room_type, AVG(CONVERT(MONEY , Avg_Room_Rate)) AverageRoomRate
FROM       Hospitality
GROUP BY   room_type


/* 6. Can you pull a list of Properties, Number of Reservations, Average room rate, where the customers didn’t show up or cancelled. */
SELECT     Property, COUNT(reservation_id) TotalReservation, AVG(CONVERT(MONEY , Avg_Room_Rate)) AverageRoomRate
FROM       Hospitality WHERE reservation_status IN('No-Show', 'Cancelled')
GROUP BY   Property
ORDER BY   1 DESC


/* 7. Can you pull a list of reservations, check in date, stay duration, the property, 
and the room type in January of 2020 where the booking channel has characters such as “Center” */
SELECT      reservation_id, check_in_date, stay_duration, Property, room_type, booking_channel
FROM        Hospitality
WHERE       check_in_date >= '2020-01-01' AND check_in_date <= '2020-01-31'
            AND booking_channel LIKE '%Center%'