BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "student_professor" (
	"student_ΑΜ"	TEXT NOT NULL,
	"professor_id"	TEXT NOT NULL,
	"visit_date"	DATE,
	FOREIGN KEY("professor_id") REFERENCES "Professor"("Id"),
	FOREIGN KEY("student_ΑΜ") REFERENCES "Student"("ΑΜ")
);
CREATE TABLE IF NOT EXISTS "Office" (
	"id"	TEXT NOT NULL DEFAULT '',
	"building"	TEXT,
	"floor"	INTEGER,
	"owner_id"	INTEGER DEFAULT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("owner_id") REFERENCES "Professor"("Id")
);
CREATE TABLE IF NOT EXISTS "Student" (
	"ΑΜ"	INTEGER(7) NOT NULL DEFAULT '',
	"fname"	TEXT NOT NULL DEFAULT '',
	"lname"	TEXT NOT NULL DEFAULT '',
	"enrolement_year"	INTEGER NOT NULL DEFAULT '',
	"semester"	INTEGER NOT NULL DEFAULT '',
	"field_of_choice"	TEXT DEFAULT NULL,
	"username"	TEXT DEFAULT '',
	"password"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("ΑΜ")
);
CREATE TABLE IF NOT EXISTS "Auditorium" (
	"id"	TEXT NOT NULL DEFAULT '',
	"name"	TEXT,
	"building"	TEXT DEFAULT NULL,
	"floor"	INTEGER DEFAULT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Location" (
	"id"	TEXT NOT NULL,
	"building"	TEXT,
	"floor"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Professor" (
	"Id"	TEXT NOT NULL DEFAULT '',
	"fname"	TEXT NOT NULL DEFAULT '',
	"lname"	TEXT NOT NULL DEFAULT '',
	"sector"	TEXT NOT NULL DEFAULT '',
	"role"	TEXT,
	"visiting_hours"	TEXT DEFAULT NULL,
	"phone_number"	INTEGER(10) NOT NULL DEFAULT '',
	"address"	TEXT DEFAULT NULL,
	"email"	STRING NOT NULL DEFAULT '',
	"username"	STRING NOT NULL,
	"password"	VARCHAR(20) NOT NULL,
	"location_id"	TEXT NOT NULL,
	PRIMARY KEY("Id"),
	FOREIGN KEY("location_id") REFERENCES "Location"("id")
);
CREATE TABLE IF NOT EXISTS "Course" (
	"id"	TEXT NOT NULL DEFAULT '',
	"name"	TEXT NOT NULL DEFAULT '',
	"semester"	INTEGER(1),
	"ECTS"	INTEGER(1) NOT NULL DEFAULT '',
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "student_audience" (
	"student_ΑΜ"	TEXT NOT NULL,
	"audience_id"	TEXT NOT NULL,
	FOREIGN KEY("student_ΑΜ") REFERENCES "Student"("ΑΜ"),
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id")
);
CREATE TABLE IF NOT EXISTS "professor_audience" (
	"professor_id"	TEXT NOT NULL,
	"audience_id"	TEXT NOT NULL,
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id"),
	FOREIGN KEY("professor_id") REFERENCES "Professor"("Id")
);
CREATE TABLE IF NOT EXISTS "audience_auditorium" (
	"auditorium_id"	TEXT NOT NULL,
	"audience_id"	TEXT NOT NULL,
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id"),
	FOREIGN KEY("auditorium_id") REFERENCES "Auditorium"("id")
);
CREATE TABLE IF NOT EXISTS "Audience" (
	"id"	TEXT NOT NULL DEFAULT '',
	"start_date"	DATE CHECK("start_date" BETWEEN '2022-10-01' AND '2050-10-05'),
	"end_date"	DATE CHECK("end_date" BETWEEN '2022-12-12' AND '2051-01-05'),
	"day"	INTEGER NOT NULL,
	"start_time"	TIME NOT NULL CHECK("start_time" BETWEEN '08:00' AND '21:00'),
	"end_time"	TIME NOT NULL CHECK("end_time" BETWEEN '09:00' AND '22:00'),
	"course_id"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id"),
	FOREIGN KEY("course_id") REFERENCES "Course"("id")
);
INSERT INTO "student_professor" ("student_ΑΜ","professor_id","visit_date") VALUES ('1023456','melet.raz','2022-11-03');
INSERT INTO "Office" ("id","building","floor","owner_id") VALUES ('7','HMTY',2,'giannopoulos'),
 ('8','CEID1',3,'andreou'),
 ('9','ΗΜΤΥ',1,'papageorgiou'),
 ('10','CEID',2,'anastasiou'),
 ('11','ΗΜΤΥ',3,'apostolou'),
 ('12','ΗΜΤΥ',1,'melet.raz'),
 ('13','CEID1',3,'syrou'),
 ('15','ΗΜΤΥ',2,'alexopoulou'),
 ('16','CEID',2,NULL),
 ('17','CEID1',3,NULL);
INSERT INTO "Student" ("ΑΜ","fname","lname","enrolement_year","semester","field_of_choice","username","password") VALUES (1023456,'Αναστασία','Αντωνίου',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1023456','wss%7775'),
 (1029921,'Ευστράτιος','Θεοδώρου',2018,9,'ΕΞΥΠΝΑ ΔΙΚΤΥΑ ΜΕ ΑΠΕ-ΥΨΗΛΕΣ ΤΑΣΕΙΣ','up1029921','jdewn**998'),
 (1045768,'Ιωάννης','Χριστοφόρου',2018,9,'ΕΞΥΠΝΑ ΔΙΚΤΥΑ ΜΕ ΑΠΕ-ΥΨΗΛΕΣ ΤΑΣΕΙΣ','up1045768','swmw877F5'),
 (1072880,'Μαρία-Ελένη','Μπουμπουκιώτη',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1072880','1234'),
 (1928212,'Ελευθερία','Παπαγεωργίου',2018,9,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1928212','dwhdjwjw%G'),
 (1928213,'Μαρία ','Θεοδώρου',2022,1,NULL,'up1928213','jwnsjn&&8'),
 (1928214,'Ιωάννα','Κομνηνού',2020,5,NULL,'up1928214','wbhwbk7782'),
 (1068215,'Αντιγόνη','Παπαελευθερίου',2019,7,'ΤΕΧΝΟΛΟΓΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ','up1068215','ewbnjkHJ3'),
 (1066573,'Ανδρέας','Συμεωνίδης',2018,9,'ΤΕΧΝΟΛΟΓΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ','up1066573','1234'),
 (1928215,'Νικηφόρος','Σκουρτιάς',2022,1,NULL,'up1928215','1234'),
 (1058216,'Αγγελική','Καραντζά',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1058216','dscds'),
 (1976211,'Κατερίνα','Παππά',2018,9,'ΕΠΙΚΟΙΝΩΝΙΕΣ','up1976211','jdns&&6'),
 (1976212,'Γιώργος','Βογιατζής',2017,11,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1976212','sjnsk2332');
INSERT INTO "Auditorium" ("id","name","building","floor") VALUES ('1','BA','CEID',0),
 ('2','ΑΠΜ4','Πολιτικών Μηχανικών',1),
 ('3','ΚΥΠΕΣΙΙ','ΗΜΤΥ',0),
 ('4','ΑΠ2','Αμφιθέατρα Πολυτεχνικών Σχολών',2),
 ('5','ΑΒ','Α'' Πρυτανείας',0),
 ('6','ΗΛ3','ΗΜΤΥ2',0),
 ('14','ΗΛ7','ΗΜΤΥ',0),
 ('18','ΚΥΠΕΣΙ','ΗΜΤΥ',0);
INSERT INTO "Location" ("id","building","floor") VALUES ('1','CEID',0),
 ('2','Πολιτικών Μηχανικών',1),
 ('3','ΗΜΤΥ',0),
 ('4','Αμφιθέατρα Πολυτεχνικών Σχολών',2),
 ('5','Α'' Πρυτανείας',0),
 ('6','ΗΜΤΥ2',0),
 ('7','ΗΜΤΥ',2),
 ('8','CEID1',3),
 ('9','ΗΜΤΥ',1),
 ('10','CEID',2),
 ('11','ΗΜΤΥ',3),
 ('12','ΗΜΤΥ',1),
 ('13','CEID1',3),
 ('14','ΗΜΤΥ',0),
 ('15','ΗΜΤΥ',2),
 ('16','CEID',2),
 ('17','CEID1',3),
 ('18','ΗΜΤΥ',0);
INSERT INTO "Professor" ("Id","fname","lname","sector","role","visiting_hours","phone_number","address","email","username","password","location_id") VALUES ('giannopoulos','Ιωάννης','Γιαννόπουλος','Συστημάτων Ηλεκτρικής Ενέργειας (ΣΗΕ)
','ΔΕΠ','Τρίτη:11:00-14:00
',6987349875,'Νόρμαν 23, Πάτρα
','i.giannopoulos@ece.upatras.gr','giannopoulos','gian1234','7'),
 ('melet.raz','Μελέτιος','Φωτεινός Ραζόφ','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΕΔΙΠ',NULL,6912654782,'Αριστοφάνους 38, Αθήνα','meletis.razof@ece.upatras.gr','melet.raz','mel7#45','12'),
 ('syrou','Στυλιανή','Σύρου','Λογικού των Υπολογιστών','ΔΕΠ','Τρίτη:11:00-14:00
Τετάρτη:13:00-16:00',6973002823,'Αμερικής 50, Πάτρα','syrou@ceid.upatras.gr','syrou','ss35*&','13'),
 ('papageorgiou','Ευάγγελος','Παπαγεωργίου','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΔΕΠ',NULL,6923845769,'Σοφοκλέους 1, Αθήνα','papageorgiou@ece.upatras.gr','papageorgiou','pap47E%%H','9'),
 ('anastasiou','Θανάσης','Αναστασίου','Υλικού και Αρχιτεκτονικής των Υπολογιστών','Αναπληρωτής','Παρασκευή:13:00-15:00
',6987652837,'Θεσσαλονίκης 345, Πάτρα','anastasiou@ceid.upatras.gr','anastasiou','anastth[kk%&','10'),
 ('andreou','Ιωάννης','Ανδρέου','Λογικού των Υπολογιστών','ΔΕΠ',NULL,6923940593,'Κορίνθου 23, Πάτρα','andreou@ceid.upatras.gr','andreou','and83Hjj(*','8'),
 ('apostolou','Αριστοτέλης','Αποστόλου','Συστημάτων Ηλεκτρικής Ενέργειας (ΣΗΕ)
','Αναπληρωτής',NULL,6912036282,'Έλληνος Στρατιώτου 24, Πάτρα','aristos.apostolou@ece.upatras.gr','apostolou','aknd%%&7','11'),
 ('alexopoulou','Φωτεινή','Αλεξοπούλου','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΔΕΠ',NULL,6972253419,'Πανεπιστημίου 84, Πάτρα','alexopoulou','alexopoulou','wdebhjjbwj^%^&','15');
INSERT INTO "Course" ("id","name","semester","ECTS") VALUES ('ECE_ΓΚ703','ΒΑΣΕΙΣ ΔΕΔΟΜΕΝΩΝ',7,5),
 ('ECE_ΒΚ702','ΥΨΗΛΕΣ ΤΑΣΕΙΣ',7,5),
 ('ECE_Y521','ΟΛΟΚΛΗΡΩΜΕΝΑ ΗΛΕΚΤΡΟΝΙΚΑ',5,8),
 ('ECE_Y422','ΑΝΑΛΥΣΗ ΔΙΚΤΥΩΝ ΙΣΧΥΟΣ',4,5),
 ('ECE_ΓΚ904','ΔΙΑΔΡΑΣΤΙΚΕΣ ΤΕΧΝΟΛΟΓΙΕΣ',9,5),
 ('ECE_Y109','ΨΗΦΙΑΚΗ ΛΟΓΙΚΗ',1,4),
 ('ECE_ΓΚ907','ΗΛΕΚΤΡΟΝΙΚΑ ΥΨΗΛΩΝ ΤΑΧΥΤΗΤΩΝ',9,5),
 ('ECE_AK705','ΤΕΧΝΗΤΗ ΝΟΗΜΟΣΥΝΗ',7,5),
 ('ECE_Υ107','ΣΥΓΧΡΟΝΗ ΦΥΣΙΚΗ',1,4);
INSERT INTO "student_audience" ("student_ΑΜ","audience_id") VALUES ('1023456','ΒΔ1'),
 ('1072880','ΒΔ2'),
 ('1068215','ΤΝ'),
 ('1072880','ΤΝ'),
 ('1066573','ΒΔ1'),
 ('1029921','ΥΤ'),
 ('1045768','ΥΤ'),
 ('1928212','ΒΔ3'),
 ('1928213','ΣΦ1'),
 ('1928213','ΨΛ'),
 ('1066573','ΔΤ1'),
 ('1928212','ΔΤ1'),
 ('1928215','ΨΛ'),
 ('1928212','ΨΛ'),
 ('1066573','ΨΛ'),
 ('1068215','ΒΔ3'),
 ('1072880','ΒΔ3'),
 ('1066573','ΒΔ3'),
 ('1072880','ΥΤ'),
 ('1072880','ΨΛ'),
 ('1928214','ΟΗ'),
 ('1058216','ΒΔ3'),
 ('1976211','ΒΔ3'),
 ('1023456','ΒΔ3'),
 ('1976212','ΒΔ3');
INSERT INTO "professor_audience" ("professor_id","audience_id") VALUES ('giannopoulos','ΥΤ'),
 ('syrou','ΒΔ2'),
 ('melet.raz','ΒΔ1'),
 ('andreou','ΔΤ1'),
 ('syrou','ΒΔ3'),
 ('apostolou','ΣΦ1'),
 ('apostolou','ΣΦ2'),
 ('anastasiou','ΨΛ'),
 ('papageorgiou','ΤΝ'),
 ('giannopoulos','ΔΙ'),
 ('melet.raz','ΔΤ2'),
 ('alexopoulou','ΟΗ');
INSERT INTO "audience_auditorium" ("auditorium_id","audience_id") VALUES ('3','ΒΔ1'),
 ('14','ΒΔ3'),
 ('2','ΣΦ1'),
 ('2','ΣΦ2'),
 ('6','ΥΤ'),
 ('1','ΔΤ1'),
 ('5','ΔΤ2'),
 ('4','ΟΗ'),
 ('14','ΤΝ'),
 ('18','ΒΔ2'),
 ('1','ΨΛ');
INSERT INTO "Audience" ("id","start_date","end_date","day","start_time","end_time","course_id") VALUES ('ΒΔ1','2022-10-04','2022-12-20',2,'09:00','11:00','ECE_ΓΚ703'),
 ('ΒΔ2','2022-10-04','2022-12-20',2,'09:00','11:00','ECE_ΓΚ703'),
 ('ΒΔ3','2022-10-05','2022-12-21',3,'10:00','13:00','ECE_ΓΚ703'),
 ('ΣΦ1','2022-10-10','2023-01-09',2,'09:00','12:00','ECE_Υ107'),
 ('ΣΦ2','2022-10-07','2023-01-13',5,'09:00','12:00','ECE_Υ107'),
 ('ΨΛ','2022-10-06','2023-01-19',4,'09:00','11:00','ECE_Y109'),
 ('ΥΤ','2022-10-13','2023-01-12',4,'12:00','14:00','ECE_ΒΚ702'),
 ('ΤΝ','2022-10-06','2023-01-12',4,'11:00','14:00','ECE_AK705'),
 ('ΔΙ','2023-02-21','2023-06-30',2,'15:00','17:00','ECE_Y422'),
 ('ΔΤ1','2022-10-10','2023-01-09',1,'15:00','17:00','ECE_ΓΚ904'),
 ('ΔΤ2','2022-10-10','2023-01-09',1,'15:00','17:00','ECE_ΓΚ904'),
 ('ΟΗ','2022-10-10','2023-01-16',1,'16:00','19:00','ECE_Y521');
COMMIT;
