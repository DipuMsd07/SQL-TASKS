--1
select f.flight_id,f.from_location,f.to_location,fp.month_name,fp.avg_price
from air_flight f,
(select flight_id,month(FLIGHT_DEPARTURE_DATE) as month_name,
avg(price) as avg_price from air_flight_details group by flight_id,MONTH(FLIGHT_DEPARTURE_DATE)) AS fp
where f.flight_id=fp.flight_id
and f.airline_name='abc'
order by f.flight_id,fp.month_name;

--2
select c.profile_id,c.FIRST_NAME,c.address,m.No_of_tickets from air_passenger_profile c,
(select min(s.total) as No_of_tickets 
from(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id)s
)m,
(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id
)t
where m.No_of_tickets=t.total
and c.profile_id=t.profile_id
order by c.FIRST_NAME

--3
select f.from_location,f.to_location,s.month_name ,sum(s.no_of_services) as no_of_services from air_flight f
join
(select flight_id,month(FLIGHT_DEPARTURE_DATE) as month_name,count(FLIGHT_DEPARTURE_DATE) as no_of_services
from air_flight_details
group by flight_id,MONTH(FLIGHT_DEPARTURE_DATE ))s
on s.flight_id=f.flight_id 
group by f.from_location,f.to_location,s.month_name
order by f.from_location,f.to_location,s.month_name

--4
select c.profile_id,c.FIRST_NAME,c.address,m.No_of_tickets from air_passenger_profile c,
(select max(s.total) as No_of_tickets 
from(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id)s
)m,
(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id
)t
where m.No_of_tickets=t.total
and c.profile_id=t.profile_id
order by c.FIRST_NAME

--5
select p.profile_id,p.FIRST_NAME,p.LAST_NAME,t.flight_id,t.FLIGHT_DEPARTURE_DATE,t.no_of_tickets
from air_passenger_profile p join
(select profile_id,flight_id,FLIGHT_DEPARTURE_DATE,count(ticket_id) as no_of_tickets
from air_ticket_info where flight_id in
(select flight_id from air_flight where from_location='chennai' and to_location='hyderabad')
group by profile_id,flight_id,FLIGHT_DEPARTURE_DATE)t
on p.profile_id=t.profile_id
order by p.profile_id,t.flight_id,t.FLIGHT_DEPARTURE_DATE

--6 
select fd.flight_id,f.from_location,f.to_location, fd.price from air_flight_details fd
join air_flight f on f.flight_id=fd.flight_id
where MONTH(FLIGHT_DEPARTURE_DATE)=04 order by fd.flight_id,f.from_location

--7
select f.flight_id,f.from_location,f.to_location ,avg(fd.price) as Average_Cost from air_flight f
join air_flight_details fd 
on f.flight_id=fd.flight_id
group by f.flight_id,f.from_location,f.to_location

--8
select distinct p.profile_id,CONCAT(p.FIRST_NAME,',',p.LAST_NAME) as Customer_Name,p.address
from air_passenger_profile p join air_ticket_info t 
on p.profile_id=t.profile_id
join air_flight f
on
f.flight_id=t.flight_id and f.from_location='chennai' and f.to_location='hyderabad'
order by p.profile_id

--9
select profile_id from air_ticket_info group by profile_id 
having count(profile_id)>= ALL
(select count(profile_id) from air_ticket_info group by profile_id)
order by profile_id

--10
select f.flight_id,f.from_location,f.to_location,count(t.ticket_id) as No_of_tickets
from air_flight f 
join air_ticket_info t
on f.flight_id=t.flight_id
where f.airline_name='abc'
group by f.flight_id,f.from_location,f.to_location having count(t.ticket_id)>=1
order by flight_id

--11
SELECT FLIGHT_ID,COUNT(FLIGHT_DEPARTURE_DATE) AS NO_OF_SERVICES,SUM(PRICE) AS TOTAL_PRICE 
FROM air_flight_details
GROUP BY FLIGHT_ID ORDER BY TOTAL_PRICE DESC,FLIGHT_ID DESC;

--12
SELECT FLIGHT_ID,FLIGHT_DEPARTURE_DATE,COUNT(TICKET_ID) AS NO_OF_PASSENGERS FROM air_ticket_info
GROUP BY FLIGHT_ID,FLIGHT_DEPARTURE_DATE ORDER BY FLIGHT_ID,FLIGHT_DEPARTURE_DATE;

--13

SELECT PROFILE_ID FROM air_ticket_info GROUP BY PROFILE_ID HAVING COUNT(TICKET_ID) = (
	SELECT MIN(C) FROM ( SELECT COUNT(TICKET_ID) AS C FROM air_ticket_info GROUP BY PROFILE_ID) AS t
);

--14
SELECT DISTINCT a.PROFILE_ID,a.FIRST_NAME,a.MOBILE_NUMBER,a.EMAIL_ID FROM air_passenger_profile a 
JOIN air_ticket_info b 
ON a.PROFILE_ID = b.PROFILE_ID JOIN air_flight c ON b.FLIGHT_ID = c.FLIGHT_ID
WHERE c.FROM_LOCATION='Hyderabad' and c.TO_LOCATION='Chennai';

--15


--16
SELECT a.PROFILE_ID,a.FIRST_NAME,a.ADDRESS AS BASE_LOCATION,COUNT(b.TICKET_ID) AS NO_OF_TICEKTS
FROM air_passenger_profile a JOIN air_ticket_info b ON a.PROFILE_ID = b.PROFILE_ID 
WHERE a.ADDRESS LIKE '%Kochi%' GROUP BY a.PROFILE_ID,a.FIRST_NAME,a.ADDRESS ORDER BY a.FIRST_NAME;

--17
SELECT a.FLIGHT_ID,a.FROM_LOCATION,a.TO_LOCATION,COUNT(b.FLIGHT_DEPARTURE_DATE) AS NO_OF_SERVICES 
FROM air_flight a JOIN air_flight_details b ON a.FLIGHT_ID = b.FLIGHT_ID
WHERE MONTH(B.FLIGHT_DEPARTURE_DATE)=5 GROUP BY a.FLIGHT_ID,a.FROM_LOCATION,a.TO_LOCATION ORDER BY FLIGHT_ID;

--18a
SELECT PROFILE_ID,LAST_NAME,MOBILE_NUMBER,EMAIL_ID FROM air_passenger_profile WHERE ADDRESS LIKE '%Chennai%' ORDER BY PROFILE_ID;

--18b
SELECT COUNT(FLIGHT_ID) AS FLIGHT_COUNT FROM air_flight WHERE DEPARTURE_TIME BETWEEN '06:00:00' AND '18:00:00' AND FROM_LOCATION='Chennai';

--19
SELECT DISTINCT a.PROFILE_ID,a.FIRST_NAME,a.EMAIL_ID,a.MOBILE_NUMBER FROM air_passenger_profile a join air_ticket_info b ON a.PROFILE_ID = b.PROFILE_ID
WHERE b.FLIGHT_ID='3148' ORDER BY a.FIRST_NAME;

--20
SELECT DISTINCT FLIGHT_ID,FROM_LOCATION,TO_LOCATION,DEPARTURE_TIME,
CASE WHEN DEPARTURE_TIME BETWEEN '05:00:01.0000000' AND '12:00:00.0000000' THEN 'Morning'
	 WHEN DEPARTURE_TIME BETWEEN '12:00:01.0000000' AND '18:00:00.0000000' THEN 'Afternoon'
	 WHEN DEPARTURE_TIME BETWEEN '18:00:01.0000000' AND '23:59:59.0000000' THEN 'Evening'
	 WHEN DEPARTURE_TIME BETWEEN '00:00:01.0000000' AND '05:00:00.0000000' THEN 'Night' 
	 ELSE 'n/a' end AS 'TIME_OF_SERVICE'
FROM air_flight ORDER BY FLIGHT_ID;


--21
SELECT FLIGHT_ID , FLIGHT_DEPARTURE_DATE, CASE WHEN PRICE < 3000 THEN 'AIR PASSENGER'
												WHEN PRICE > 3000 AND PRICE < 4000 THEN 'AIR BUS'
												WHEN PRICE > 4000 THEN 'EXECUTIVE PASSENGER'
												ELSE 'NONE'
												END AS 'FLIGHT TYPE'
												FROM air_flight_details
												GROUP BY FLIGHT_ID, FLIGHT_DEPARTURE_DATE, PRICE
												ORDER BY FLIGHT_ID, FLIGHT_DEPARTURE_DATE


--22
SELECT * FROM air_credit_card_details
SELECT CARD_TYPE ,COUNT(CARD_TYPE) AS 'CARD_COUNT' FROM air_credit_card_details GROUP BY CARD_TYPE 

--23
SELECT SUBSTRING(PROFILE_ID, 4,6) AS 'SERIAL_NO' ,FIRST_NAME, MOBILE_NUMBER,EMAIL_ID 
FROM air_passenger_profile WHERE EMAIL_ID LIKE ('%GMAIL.COM%') ORDER BY FIRST_NAME


--24(INCOMPLETE)

--25
SELECT FROM_LOCATION, COUNT(FROM_LOCATION) AS 'NO_OF_FLIGHTS' FROM air_flight GROUP BY FROM_LOCATION


--26(NOT ACCURATE)
SELECT A.FLIGHT_ID, B.FROM_LOCATION, B.TO_LOCATION, A.FLIGHT_DEPARTURE_DATE, COUNT(TICKET_ID) AS 'NO_OF_PASSENGERS' 
FROM air_ticket_info A JOIN air_flight B
ON A.FLIGHT_ID = B.FLIGHT_ID 
WHERE STATUS = 'BOOKED'
GROUP BY A.FLIGHT_ID, A.FLIGHT_DEPARTURE_DATE,B.FROM_LOCATION,B.TO_LOCATION

--27
SELECT B.FLIGHT_ID, B.FROM_LOCATION, B.TO_LOCATION, B.TOTAL_SEATS, (B.TOTAL_SEATS - A.AVAILABLE_SEATS) AS 'NO_OF_SEATS_BOOKED' 
FROM air_flight_details A JOIN air_flight B 
ON A.FLIGHT_ID = B.FLIGHT_ID 
WHERE A.AVAILABLE_SEATS < 0.1*B.TOTAL_SEATS

--28
SELECT A.FLIGHT_ID, B.FLIGHT_DEPARTURE_DATE, A.FROM_LOCATION, A.TO_LOCATION, A.DURATION 
FROM air_flight A JOIN air_flight_details B 
ON A.FLIGHT_ID = B.FLIGHT_ID AND A.DURATION < '01:10:00' 
ORDER BY B.FLIGHT_ID ASC
--GROUP BY A.FLIGHT_ID, B.FLIGHT_DEPARTURE_DATE, A.FROM_LOCATION

--29
