SELECT DATENAME(MONTH,2013-04-29) AS MONTH;

INSERT INTO air_passenger_profile VALUES('abc@123','abc123','George','Geller','34,demo Street,United States',1234567890,'abc@gmail.com'),
										('def@123','def123','Rohan','Sharma','21,Wall Street,Pune',2345678901,'def@gmail.com'),
										('ghi@123','ghi123','Mohit','Jain','32,Laxmi Road,Pune',3456789012,'ghi@gmail.com');

INSERT INTO air_credit_card_details VALUES('abc@123',5555555555554444,'MASTERCARD',06,2025),
										  ('def@123',4012888888881881,'VISA',03,2027),
										  ('ghi@123',6011000990139424,'DISCOVER',08,2023);

INSERT INTO air_flight VALUES('1011','5001','SPICEJET','HYDERABAD','CHENNAI','19:55:00','20:55:00','1:00:00',20),
							 ('1012','5002','AIRBUS','CHENNAI','HYDERABAD','07:30:00','08:00:00','0:30:00',30),
							 ('289','5003','AIRBUS','CHENNAI','KOCHI','10:30:00','12:00:00','1:30:00',40);

INSERT INTO air_flight_details VALUES('1011','2022-04-29',4000.00,10),
									 ('1012','2020-06-20',8000.00,15),
									 ('289','2022-03-08',10000.00,20);

INSERT INTO air_ticket_info VALUES('TK100','abc@123','1011','2022-04-29','BOOKED'),
								  ('TK101','def@123','1011','2022-04-29','BOOKED'),
								  ('TK102','ghi@123','1011','2022-04-29','BOOKED');

SELECT * FROM air_credit_card_details;
SELECT * FROM air_flight;
SELECT * FROM air_flight_details;
SELECT * FROM air_passenger_profile;
SELECT * FROM air_ticket_info;
