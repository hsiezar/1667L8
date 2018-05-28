DROP TABLE has CASCADE;
DROP TABLE uses CASCADE;
DROP TABLE repair_request CASCADE;
DROP TABLE repairs CASCADE;
DROP TABLE Reserved CASCADE;
DROP TABLE Confirmed CASCADE;
DROP TABLE Waitlisted CASCADE;
DROP TABLE Reservation CASCADE;
DROP TABLE Schedule CASCADE;
DROP TABLE Flight CASCADE;
DROP TABLE Pilot CASCADE;
DROP TABLE Plane CASCADE;
DROP TABLE Technician CASCADE;
DROP TABLE Customer CASCADE;

CREATE TABLE Customer(first_name Char, last_name Char, gender Char, dob DATE,
                       address Char, contact Char(10), cid Int NOT NULL,
                       zip Char(5),
                       PRIMARY KEY(cid));

CREATE TABLE Technician(tid Int NOT NULL, PRIMARY KEY(tid));

CREATE TABLE Plane(model Int, plane_id Int NOT NULL, make Char, age Int,
                   num_seats INT, PRIMARY KEY(plane_id));

CREATE TABLE Pilot(pil_id Int NOT NULL, name Char, nationality Char,
                   PRIMARY KEY(pil_id));

CREATE TABLE Flight(cost Int, num_sold Int, num_stops Int, aad DATE,
                      aat Char(5), add DATE, adt Char(5), source Char,
                      destination Char, flight_num Int NOT NULL,
                      PRIMARY KEY(flight_num));

CREATE TABLE Schedule(flight_num Int NOT NULL, day DATE, depart_time char(5),
                      arrive_time Char(5),
                      PRIMARY KEY(flight_num),
                      FOREIGN KEY(flight_num) REFERENCES Flight(flight_num)
                      ON DELETE CASCADE);

CREATE TABLE Reservation(Rnum Int NOT NULL, PRIMARY KEY(Rnum));

CREATE TABLE Waitlisted(Rnum Int NOT NULL, PRIMARY KEY(Rnum),
                        FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum)
                        ON DELETE CASCADE);

CREATE TABLE Confirmed(Rnum Int NOT NULL, PRIMARY KEY(Rnum),
                       FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum)
                       ON DELETE CASCADE);

CREATE TABLE Reserved(Rnum Int NOT NULL, PRIMARY KEY(Rnum),
                      FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum)
                      ON DELETE CASCADE);

CREATE TABLE repairs(plane_id Int NOT NULL, tid Int NOT NULL,
                     date_of_repair DATE, code Int, Primary KEY(plane_id,tid),
                     FOREIGN KEY(plane_id) REFERENCES Plane(plane_id)
                     ON DELETE CASCADE,
                     FOREIGN KEY(tid) REFERENCES Technician(tid)
                     ON DELETE NO ACTION);

CREATE TABLE repair_request(pil_id Int NOT NULL, plane_id Int NOT NULL,
                            tid Int NOT NULL, repair_id INT NOT NULL,
                            PRIMARY KEY(pil_id, Plane_id, tid),
                            FOREIGN KEY(pil_id) REFERENCES Pilot(pil_id)
                            ON DELETE CASCADE,
                            FOREIGN KEY(plane_id) REFERENCES Plane(plane_id)
                            ON DELETE CASCADE,
                            FOREIGN KEY(tid) REFERENCES Technician(tid)
                            ON DELETE CASCADE);

CREATE TABLE uses(flight_num Int NOT NULL, pil_id Int NOT NULL,
                  plane_id Int NOT NULL, PRIMARY KEY(flight_num,pil_id,plane_id),
                  FOREIGN KEY(flight_num) REFERENCES Flight(flight_num)
                  ON DELETE CASCADE,
                  FOREIGN KEY(pil_id) REFERENCES Pilot(pil_id)
                  ON DELETE CASCADE,
                  FOREIGN KEY(plane_id) REFERENCES Plane(plane_id)
                  ON DELETE CASCADE);

CREATE TABLE has(flight_num Int NOT NULL, cid int NOT NULL, Rnum int NOT NULL,
                 PRIMARY KEY(flight_num, cid, Rnum),
                 FOREIGN KEY(flight_num) REFERENCES Flight(flight_num)
                 ON DELETE CASCADE,
                 FOREIGN KEY(cid) REFERENCES Customer(cid)
                 ON DELETE CASCADE,
                 FOREIGN KEY(Rnum) REFERENCES Reservation
                 ON DELETE CASCADE);

