BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "student_professor" (
	"student_ΑΜ"	TEXT NOT NULL,
	"professor_id"	TEXT NOT NULL,
	"visit_date"	DATE,
	FOREIGN KEY("student_ΑΜ") REFERENCES "Student"("ΑΜ"),
	FOREIGN KEY("professor_id") REFERENCES "Professor"("Id")
);
CREATE TABLE IF NOT EXISTS "Office" (
	"id"	TEXT NOT NULL DEFAULT '',
	"building"	TEXT,
	"floor"	INTEGER,
	"owner_id"	INTEGER DEFAULT NULL,
	FOREIGN KEY("owner_id") REFERENCES "Professor"("Id"),
	PRIMARY KEY("id")
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
	FOREIGN KEY("location_id") REFERENCES "Location"("id"),
	PRIMARY KEY("Id")
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
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id"),
	FOREIGN KEY("student_ΑΜ") REFERENCES "Student"("ΑΜ")
);
CREATE TABLE IF NOT EXISTS "professor_audience" (
	"professor_id"	TEXT NOT NULL,
	"audience_id"	TEXT NOT NULL,
	FOREIGN KEY("professor_id") REFERENCES "Professor"("Id"),
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id")
);
CREATE TABLE IF NOT EXISTS "audience_auditorium" (
	"auditorium_id"	TEXT NOT NULL,
	"audience_id"	TEXT NOT NULL,
	FOREIGN KEY("auditorium_id") REFERENCES "Auditorium"("id"),
	FOREIGN KEY("audience_id") REFERENCES "Audience"("id")
);
CREATE TABLE IF NOT EXISTS "Audience" (
	"id"	TEXT NOT NULL DEFAULT '',
	"start_date"	DATE,
	"end_date"	DATE,
	"day"	INTEGER NOT NULL DEFAULT '',
	"start_time"	TIME NOT NULL DEFAULT '',
	"end_time"	TIME NOT NULL DEFAULT '',
	"course_id"	TEXT NOT NULL DEFAULT '',
	FOREIGN KEY("course_id") REFERENCES "Course"("id"),
	PRIMARY KEY("id")
);
INSERT INTO "student_professor" VALUES ('1023456','melet.raz','2022-11-03');
INSERT INTO "Office" VALUES ('7','HMTY',2,'giannopoulos');
INSERT INTO "Office" VALUES ('8','CEID1',3,'andreou');
INSERT INTO "Office" VALUES ('9','ΗΜΤΥ',1,'papageorgiou');
INSERT INTO "Office" VALUES ('10','CEID',2,'anastasiou');
INSERT INTO "Office" VALUES ('11','ΗΜΤΥ',3,'apostolou');
INSERT INTO "Office" VALUES ('12','ΗΜΤΥ',1,'melet.raz');
INSERT INTO "Office" VALUES ('13','CEID1',3,'syrou');
INSERT INTO "Office" VALUES ('15','ΗΜΤΥ',2,'alexopoulou');
INSERT INTO "Office" VALUES ('16','CEID',2,NULL);
INSERT INTO "Office" VALUES ('17','CEID1',3,NULL);
INSERT INTO "Student" VALUES (1023456,'Αναστασία','Αντωνίου',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1023456','wss%7775');
INSERT INTO "Student" VALUES (1029921,'Ευστράτιος','Θεοδώρου',2018,9,'ΕΞΥΠΝΑ ΔΙΚΤΥΑ ΜΕ ΑΠΕ-ΥΨΗΛΕΣ ΤΑΣΕΙΣ','up1029921','jdewn**998');
INSERT INTO "Student" VALUES (1045768,'Ιωάννης','Χριστοφόρου',2018,9,'ΕΞΥΠΝΑ ΔΙΚΤΥΑ ΜΕ ΑΠΕ-ΥΨΗΛΕΣ ΤΑΣΕΙΣ','up1045768','swmw877F5');
INSERT INTO "Student" VALUES (1072880,'Μαρία-Ελένη','Μπουμπουκιώτη',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1072880','1234');
INSERT INTO "Student" VALUES (1928212,'Ελευθερία','Παπαγεωργίου',2018,9,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1928212','dwhdjwjw%G');
INSERT INTO "Student" VALUES (1928213,'Μαρία ','Θεοδώρου',2022,1,NULL,'up1928213','jwnsjn&&8');
INSERT INTO "Student" VALUES (1928214,'Ιωάννα','Κομνηνού',2020,5,NULL,'up1928214','wbhwbk7782');
INSERT INTO "Student" VALUES (1068215,'Αντιγόνη','Παπαελευθερίου',2019,7,'ΤΕΧΝΟΛΟΓΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ','up1068215','ewbnjkHJ3');
INSERT INTO "Student" VALUES (1066573,'Ανδρέας','Συμεωνίδης',2018,9,'ΤΕΧΝΟΛΟΓΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ','up1066573','1234');
INSERT INTO "Student" VALUES (1928215,'Νικηφόρος','Σκουρτιάς',2022,1,NULL,'up1928215','1234');
INSERT INTO "Student" VALUES (1058216,'Αγγελική','Καραντζά',2019,7,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1058216','dscds');
INSERT INTO "Student" VALUES (1976211,'Κατερίνα','Παππά',2018,9,'ΕΠΙΚΟΙΝΩΝΙΕΣ','up1976211','jdns&&6');
INSERT INTO "Student" VALUES (1976212,'Γιώργος','Βογιατζής',2017,11,'ΥΠΟΛΟΓΙΣΤΕΣ: ΛΟΓΙΣΜΙΚΟ και ΥΛΙΚΟ','up1976212','sjnsk2332');
INSERT INTO "Auditorium" VALUES ('1','BA','CEID',0);
INSERT INTO "Auditorium" VALUES ('2','ΑΠΜ4','Πολιτικών Μηχανικών',1);
INSERT INTO "Auditorium" VALUES ('3','ΚΥΠΕΣΙΙ','ΗΜΤΥ',0);
INSERT INTO "Auditorium" VALUES ('4','ΑΠ2','Αμφιθέατρα Πολυτεχνικών Σχολών',2);
INSERT INTO "Auditorium" VALUES ('5','ΑΒ','Α'' Πρυτανείας',0);
INSERT INTO "Auditorium" VALUES ('6','ΗΛ3','ΗΜΤΥ2',0);
INSERT INTO "Auditorium" VALUES ('14','ΗΛ7','ΗΜΤΥ',0);
INSERT INTO "Auditorium" VALUES ('18','ΚΥΠΕΣΙ','ΗΜΤΥ',0);
INSERT INTO "Location" VALUES ('1','CEID',0);
INSERT INTO "Location" VALUES ('2','Πολιτικών Μηχανικών',1);
INSERT INTO "Location" VALUES ('3','ΗΜΤΥ',0);
INSERT INTO "Location" VALUES ('4','Αμφιθέατρα Πολυτεχνικών Σχολών',2);
INSERT INTO "Location" VALUES ('5','Α'' Πρυτανείας',0);
INSERT INTO "Location" VALUES ('6','ΗΜΤΥ2',0);
INSERT INTO "Location" VALUES ('7','ΗΜΤΥ',2);
INSERT INTO "Location" VALUES ('8','CEID1',3);
INSERT INTO "Location" VALUES ('9','ΗΜΤΥ',1);
INSERT INTO "Location" VALUES ('10','CEID',2);
INSERT INTO "Location" VALUES ('11','ΗΜΤΥ',3);
INSERT INTO "Location" VALUES ('12','ΗΜΤΥ',1);
INSERT INTO "Location" VALUES ('13','CEID1',3);
INSERT INTO "Location" VALUES ('14','ΗΜΤΥ',0);
INSERT INTO "Location" VALUES ('15','ΗΜΤΥ',2);
INSERT INTO "Location" VALUES ('16','CEID',2);
INSERT INTO "Location" VALUES ('17','CEID1',3);
INSERT INTO "Location" VALUES ('18','ΗΜΤΥ',0);
INSERT INTO "Professor" VALUES ('giannopoulos','Ιωάννης','Γιαννόπουλος','Συστημάτων Ηλεκτρικής Ενέργειας (ΣΗΕ)
','ΔΕΠ','Τρίτη:11:00-14:00
',6987349875,'Νόρμαν 23, Πάτρα
','i.giannopoulos@ece.upatras.gr','giannopoulos','gian1234','7');
INSERT INTO "Professor" VALUES ('melet.raz','Μελέτιος','Φωτεινός Ραζόφ','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΕΔΙΠ',NULL,6912654782,'Αριστοφάνους 38, Αθήνα','meletis.razof@ece.upatras.gr','melet.raz','mel7#45','12');
INSERT INTO "Professor" VALUES ('syrou','Στυλιανή','Σύρου','Λογικού των Υπολογιστών','ΔΕΠ','Τρίτη:11:00-14:00
Τετάρτη:13:00-16:00',6973002823,'Αμερικής 50, Πάτρα','syrou@ceid.upatras.gr','syrou','ss35*&','13');
INSERT INTO "Professor" VALUES ('papageorgiou','Ευάγγελος','Παπαγεωργίου','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΔΕΠ',NULL,6923845769,'Σοφοκλέους 1, Αθήνα','papageorgiou@ece.upatras.gr','papageorgiou','pap47E%%H','9');
INSERT INTO "Professor" VALUES ('anastasiou','Θανάσης','Αναστασίου','Υλικού και Αρχιτεκτονικής των Υπολογιστών','Αναπληρωτής','Παρασκευή:13:00-15:00
',6987652837,'Θεσσαλονίκης 345, Πάτρα','anastasiou@ceid.upatras.gr','anastasiou','anastth[kk%&','10');
INSERT INTO "Professor" VALUES ('andreou','Ιωάννης','Ανδρέου','Λογικού των Υπολογιστών','ΔΕΠ',NULL,6923940593,'Κορίνθου 23, Πάτρα','andreou@ceid.upatras.gr','andreou','and83Hjj(*','8');
INSERT INTO "Professor" VALUES ('apostolou','Αριστοτέλης','Αποστόλου','Συστημάτων Ηλεκτρικής Ενέργειας (ΣΗΕ)
','Αναπληρωτής',NULL,6912036282,'Έλληνος Στρατιώτου 24, Πάτρα','aristos.apostolou@ece.upatras.gr','apostolou','aknd%%&7','11');
INSERT INTO "Professor" VALUES ('alexopoulou','Φωτεινή','Αλεξοπούλου','Ηλεκτρονικής και Υπολογιστών (Η/Υ)','ΔΕΠ',NULL,6972253419,'Πανεπιστημίου 84, Πάτρα','alexopoulou','alexopoulou','wdebhjjbwj^%^&','15');
INSERT INTO "Course" VALUES ('ECE_ΓΚ703','ΒΑΣΕΙΣ ΔΕΔΟΜΕΝΩΝ',7,5);
INSERT INTO "Course" VALUES ('ECE_ΒΚ702','ΥΨΗΛΕΣ ΤΑΣΕΙΣ',7,5);
INSERT INTO "Course" VALUES ('ECE_Y521','ΟΛΟΚΛΗΡΩΜΕΝΑ ΗΛΕΚΤΡΟΝΙΚΑ',5,8);
INSERT INTO "Course" VALUES ('ECE_Y422','ΑΝΑΛΥΣΗ ΔΙΚΤΥΩΝ ΙΣΧΥΟΣ',4,5);
INSERT INTO "Course" VALUES ('ECE_ΓΚ904','ΔΙΑΔΡΑΣΤΙΚΕΣ ΤΕΧΝΟΛΟΓΙΕΣ',9,5);
INSERT INTO "Course" VALUES ('ECE_Y109','ΨΗΦΙΑΚΗ ΛΟΓΙΚΗ',1,4);
INSERT INTO "Course" VALUES ('ECE_ΓΚ907','ΗΛΕΚΤΡΟΝΙΚΑ ΥΨΗΛΩΝ ΤΑΧΥΤΗΤΩΝ',9,5);
INSERT INTO "Course" VALUES ('ECE_AK705','ΤΕΧΝΗΤΗ ΝΟΗΜΟΣΥΝΗ',7,5);
INSERT INTO "Course" VALUES ('ECE_Υ107','ΣΥΓΧΡΟΝΗ ΦΥΣΙΚΗ',1,4);
INSERT INTO "student_audience" VALUES ('1023456','ΒΔ1');
INSERT INTO "student_audience" VALUES ('1072880','ΒΔ2');
INSERT INTO "student_audience" VALUES ('1068215','ΤΝ');
INSERT INTO "student_audience" VALUES ('1072880','ΤΝ');
INSERT INTO "student_audience" VALUES ('1066573','ΒΔ1');
INSERT INTO "student_audience" VALUES ('1029921','ΥΤ');
INSERT INTO "student_audience" VALUES ('1045768','ΥΤ');
INSERT INTO "student_audience" VALUES ('1928212','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1928213','ΣΦ1');
INSERT INTO "student_audience" VALUES ('1928213','ΨΛ');
INSERT INTO "student_audience" VALUES ('1066573','ΔΤ1');
INSERT INTO "student_audience" VALUES ('1928212','ΔΤ1');
INSERT INTO "student_audience" VALUES ('1928215','ΨΛ');
INSERT INTO "student_audience" VALUES ('1928212','ΨΛ');
INSERT INTO "student_audience" VALUES ('1066573','ΨΛ');
INSERT INTO "student_audience" VALUES ('1068215','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1072880','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1066573','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1072880','ΥΤ');
INSERT INTO "student_audience" VALUES ('1072880','ΨΛ');
INSERT INTO "student_audience" VALUES ('1928214','ΟΗ');
INSERT INTO "student_audience" VALUES ('1058216','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1976211','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1023456','ΒΔ3');
INSERT INTO "student_audience" VALUES ('1976212','ΒΔ3');
INSERT INTO "professor_audience" VALUES ('giannopoulos','ΥΤ');
INSERT INTO "professor_audience" VALUES ('syrou','ΒΔ2');
INSERT INTO "professor_audience" VALUES ('melet.raz','ΒΔ1');
INSERT INTO "professor_audience" VALUES ('andreou','ΔΤ1');
INSERT INTO "professor_audience" VALUES ('syrou','ΒΔ3');
INSERT INTO "professor_audience" VALUES ('apostolou','ΣΦ1');
INSERT INTO "professor_audience" VALUES ('apostolou','ΣΦ2');
INSERT INTO "professor_audience" VALUES ('anastasiou','ΨΛ');
INSERT INTO "professor_audience" VALUES ('papageorgiou','ΤΝ');
INSERT INTO "professor_audience" VALUES ('giannopoulos','ΔΙ');
INSERT INTO "professor_audience" VALUES ('melet.raz','ΔΤ2');
INSERT INTO "professor_audience" VALUES ('alexopoulou','ΟΗ');
INSERT INTO "audience_auditorium" VALUES ('3','ΒΔ1');
INSERT INTO "audience_auditorium" VALUES ('14','ΒΔ3');
INSERT INTO "audience_auditorium" VALUES ('2','ΣΦ1');
INSERT INTO "audience_auditorium" VALUES ('2','ΣΦ2');
INSERT INTO "audience_auditorium" VALUES ('6','ΥΤ');
INSERT INTO "audience_auditorium" VALUES ('1','ΔΤ1');
INSERT INTO "audience_auditorium" VALUES ('5','ΔΤ2');
INSERT INTO "audience_auditorium" VALUES ('4','ΟΗ');
INSERT INTO "audience_auditorium" VALUES ('14','ΤΝ');
INSERT INTO "audience_auditorium" VALUES ('18','ΒΔ2');
INSERT INTO "audience_auditorium" VALUES ('1','ΨΛ');
INSERT INTO "Audience" VALUES ('ΒΔ1','2022-10-04','2022-12-20',2,'09:00','11:00','ECE_ΓΚ703');
INSERT INTO "Audience" VALUES ('ΒΔ2','2022-10-04','2022-12-20',2,'09:00','11:00','ECE_ΓΚ703');
INSERT INTO "Audience" VALUES ('ΒΔ3','2022-10-05','2022-12-21',3,'10:00','13:00','ECE_ΓΚ703');
INSERT INTO "Audience" VALUES ('ΣΦ1','2022-10-10','2023-01-09',2,'09:00','12:00','ECE_Υ107');
INSERT INTO "Audience" VALUES ('ΣΦ2','2022-10-07','2023-01-13',5,'09:00','12:00','ECE_Υ107');
INSERT INTO "Audience" VALUES ('ΨΛ','2022-10-06','2023-01-19',4,'09:00','11:00','ECE_Y109');
INSERT INTO "Audience" VALUES ('ΥΤ','2022-10-13','2023-01-12',4,'12:00','14:00','ECE_ΒΚ702');
INSERT INTO "Audience" VALUES ('ΤΝ','2022-10-06','2023-01-12',4,'11:00','14:00','ECE_AK705');
INSERT INTO "Audience" VALUES ('ΔΙ','2022-10-04',NULL,2,'15:00','17:00','ECE_Y422');
INSERT INTO "Audience" VALUES ('ΔΤ1','2022-10-10','2023-01-09',1,'15:00','17:00','ECE_ΓΚ904');
INSERT INTO "Audience" VALUES ('ΔΤ2','2022-10-10','2023-01-09',1,'15:00','17:00','ECE_ΓΚ904');
INSERT INTO "Audience" VALUES ('ΟΗ','2022-10-10','2023-01-16',1,'16:00','19:00','ECE_Y521');
COMMIT;
