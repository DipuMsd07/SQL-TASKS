--1
select f.flight_id,f.from_location,f.to_location,fp.month_name,fp.avg_price
from air_flight f,
(select flight_id,month(FLIGHT_DEPARTURE_DATE) as month_name,
avg(price) as avg_price from air_flight_details group by flight_id,MONTH(FLIGHT_DEPARTURE_DATE))fp
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
select f.from_location,f.to_location,s.month_name ,sum(s.no_of_services) from air_flight f
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



--11
SELECT a.FLIGHT_ID,COUNT(a.FLIGHT_DEPARTURE_DATE) AS NO_OF_SERVICES,SUM(b.PRICE) as TOTAL_PRICE FROM air_ticket_info a JOIN air_flight_details b 
ON a.FLIGHT_ID = b.FLIGHT_ID GROUP BY a.FLIGHT_ID ORDER BY TOTAL_PRICE DESC,a.FLIGHT_ID DESC;

--12
SELECT FLIGHT_ID,FLIGHT_DEPARTURE_DATE,COUNT(TICKET_ID) AS NO_OF_PASSENGERS FROM air_ticket_info
GROUP BY FLIGHT_ID,FLIGHT_DEPARTURE_DATE ORDER BY FLIGHT_ID,FLIGHT_DEPARTURE_DATE;

--13
SELECT PROFILE_ID FROM air_ticket_info GROUP BY PROFILE_ID HAVING COUNT(TICKET_ID) = (
	SELECT MIN(C) FROM ( SELECT COUNT(TICKET_ID) AS C FROM air_ticket_info GROUP BY PROFILE_ID) t
) ORDER BY PROFILE_ID;

--14
SELECT DISTINCT a.PROFILE_ID,a.FIRST_NAME,a.MOBILE_NUMBER,a.EMAIL_ID FROM air_passenger_profile a JOIN air_ticket_info b 
ON a.PROFILE_ID = b.PROFILE_ID JOIN air_flight c ON b.FLIGHT_ID = c.FLIGHT_ID
WHERE c.FROM_LOCATION='Hyderabad' and c.TO_LOCATION='Chennai' ORDER BY a.PROFILE_ID;

--15
SELECT distinct a.PROFILE_ID,a.FIRST_NAME,a.LAST_NAME,c.FLIGHT_ID,b.FLIGHT_DEPARTURE_DATE,
c.ARRIVAL_TIME,DATEADD(c.DEPARTURE_TIME,'01:00:00') AS DELAYED_DEPARTURE_TIME,ADDTIME(c.ARRIVAL_TIME,'01:00:00') AS DELAYED_ARRIVAL_TIME 
FROM air_passenger_profile a 
JOIN air_ticket_info b ON a.PROFILE_ID=b.PROFILE_ID
JOIN air_flight c ON b.FLIGHT_ID = c.FLIGHT_ID 
WHERE b.FLIGHT_DEPARTURE_DATE='2013-05-06' AND c.FROM_LOCATION='Chennai' AND c.TO_LOCATION='Hyderabad' ORDER BY a.PROFILE_ID;


--16
SELECT a.PROFILE_ID,a.FIRST_NAME,SUBSTRING(SUBSTRING(ADDRESS,'-',2),'-',-1) AS BASE_LOCATION,COUNT(b.TICKET_ID) AS NO_OF_TICEKTS
FROM air_passenger_profile a JOIN air_ticket_info b ON a.PROFILE_ID = b.PROFILE_ID 
WHERE SUBSTRING(SUBSTRING(ADDRESS,'-',2),'-',-1)='Kochi' GROUP BY a.PROFILE_ID ORDER BY a.FIRST_NAME;

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
	 ELSE 'n/a' end 'TIME_OF_SERVICE'
FROM air_flight ORDER BY FLIGHT_ID;