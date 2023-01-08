import sqlite3;
#Σύνδεση με τη βάση
conn = sqlite3.connect("project1.db");
c = conn.cursor();

#Συναρτήσεις Login
def login_foithths(): #Login Φοιτητή
    print("Επιλέξατε είσοδο φοιτητή")
    username=input("Παρακαλώ πληκτρολόγησε το username σου: \n")
    buf="SELECT * FROM Student WHERE username='"+username+"';"
    try:
        c.execute(buf)
        result = c.fetchall()
        if(len(result)!=1):
            print("Το όνομα χρήστη που πληκτρολογήσατε δεν είναι σωστό. Παρακαλω δοκίμασε ξανά.")
            main()
            return
        id=result[0][6]
        AM=result[0][0]
        swsto_password=result[0][7]
        password=input("Παρακαλώ πληκτρολόγησε τον κωδικό σου: \n")
        if password==swsto_password:
            print("Επιτυχής σύνδεση! \nΚαλώς όρισες", result[0][1])
            foithths(AM)
        else:
            print("Ο κωδικός που πληκτρολογήσατε είναι λανθασμένος. Παρακαλω δοκίμασε ξανά.\n")
            main()
        conn.commit()
    except:
        print("Failed to execute")
        return

def login_ka8hghths(): #Login Καθηγητή
    print("Επιλέξατε είσοδο Καθηγητή")
    
    username=input("Παρακαλώ πληκτρολόγησε το username σου: \n")
    buf="SELECT * FROM Professor WHERE username='"+username+"';"
    try:
        c.execute(buf)
        result = c.fetchall()
        if(len(result)!=1):
            print("Το όνομα χρήστη που πληκτρολογήσατε δεν είναι σωστό. Παρακαλω δοκίμασε ξανά.")
            main()
            return
        id=result[0][9]
        swsto_password=result[0][10]
        password=input("Παρακαλώ πληκτρολόγησε τον κωδικό σου: \n")
        if password==swsto_password:
            print("Επιτυχής σύνδεση! \nΚαλώς όρισες", result[0][1])
            ka8hghths(username)
        else:
            print("Ο κωδικός που πληκτρολογήσατε είναι λανθασμένος. Παρακαλω δοκίμασε ξανά.\n")
            main()
        conn.commit()
    except:
        print("Error")
        return

#Συναρτήσεις Φοιτητή

def foithths(AM):
    #Επιλογή λειτουργίας
    epilogh_foit=input("\nΕπέλεξε λειτουργία:\n1 --> Που έχω μάθημα τώρα;\n2 --> Ψάχνω κάποιον καθηγητή\n\
3 --> Ποιά μαθήματα επικαλύπτονται μεταξύ τους;\n4 --> Ποιο είναι το προγραμμά μου; \n5 --> Εγγραφή/Απεγγραφή από μάθημα \n")
    while True:
        if epilogh_foit=="1":
            pou_ma8hma(AM)
        elif epilogh_foit=="2":
            pou_ka8hghths(AM)
        elif epilogh_foit=="3":
            epikalisph(AM)
        elif epilogh_foit=="4":
            programma(AM)
        elif epilogh_foit=="5":
            eggrafh(AM)
        elif epilogh_foit==" ":
            print("Επιστροφή στην αρχική σελίδα.")
            main()
        else:
            print("Παρακαλώ δώσε κατάλληλο input.\n")
            foithths(AM)
        break
        

def pou_ma8hma(AM): #Συνάρτηση "Που έχω μάθημα τώρα"
    buf="SELECT Course.name, Auditorium.name, Auditorium.building, Auditorium.floor FROM (Audience JOIN Course on course_id=Course.id)\
JOIN audience_auditorium JOIN Auditorium JOIN student_audience ON student_ΑΜ='"+str(AM)+"' WHERE start_time<=time('now','localtime')\
AND end_time>=time('now','localtime') AND start_date<=date('now','localtime') AND end_date>=date('now','localtime') AND strftime('%w','now')=Audience.day GROUP BY Course.id;"
    try:
        c.execute(buf)
        result=c.fetchall()
        print("Μάθημα:", result[0][0], ", Αίθουσα:", result[0][1], ", Κτήριο:", result[0][2], ", Όροφος:", result[0][3])
    except:
        print("Δεν έχεις κάποιο μάθημα τώρα.")
    foithths(AM)
    return


def pou_ka8hghths(AM): #Συνάρτηση "Ψάχνω κάποιον καθηγητή"
    buf="SELECT id, fname, lname FROM Professor"
    try:
        c.execute(buf)
        result=c.fetchall()
        print("Εγγεγραμμένοι καθηγητές τμήματος:")
        check_proff=[]
        for i in range(len(result)):
            print("ID Καθηγητή:", result[i][0], "Ονοματεπώνυμο Καθηγητή:", result[i][1], result[i][2])
            check_proff.append(result[i][0])
        prof_id=input("Πληκτρολόγησε το ID του καθηγητή που αναζητείς: \n")
        if prof_id not in check_proff: #Έλεγχος αν το input είναι κατάλληλο
            print("Παρακαλώ πληκτρολόγησε κατάλληλο κωδικό καθηγητή.")
        else:
            #Έλεγχος εαν ο καθηγητής βρίσκεται αυτή τη στιγμή σε μάθημα
            buf="SELECT fname, lname, Auditorium.name, Auditorium.building, Auditorium.floor, Audience.end_time  FROM professor_audience as pa \
JOIN Professor as p JOIN Audience JOIN audience_auditorium as aa JOIN Auditorium on Audience.id=aa.audience_id AND Auditorium.id=aa.auditorium_id \
AND pa.professor_id=p.id AND pa.audience_id=Audience.id WHERE p.id='"+str(prof_id)+"' AND start_time<=time('now','localtime') AND end_time>=time('now','localtime') and day=strftime('%w','now','localtime');"
            c.execute(buf)
            result=c.fetchall()        
            if len(result)!=0: #Εμφάνιση της αίθουσας που βρίσκεται ο καθηγητής
                print("Ο Καθηγητης", result[0][0], result[0][1], "αυτή τη στιγμή βρίσκεται σε διάλεξη στην αίθουσα", result[0][2], "η οποία βρίσκεται στο κτήριο", result[0][3], "στον όροφο", result[0][4], "\nΗ διάλεξη που παραδίδει ολοκληρώνεται στις", result[0][5])
            #Εναλλακτικά εμφάνιση γραφείου του καθηγητή
            else:
                buf="SELECT p.fname, p.lname, p.sector, p.visiting_hours, o.building, o.floor FROM Professor as p JOIN Office as o on p.id=o.owner_id WHERE p.id='"+str(prof_id)+"';"
                try:
                    c.execute(buf)
                    result=c.fetchall()
                    print("Το γραφείο του καθηγητή βρίσκεται στο κτήριο", result[0][4], "στον όροφο", result[0][5])
                    try:
                        if len(result[0][3])!=0: #Έλεγχος εάν υπάρχουν ώρες γραφείου περασμένες στη βάση
                            print("Οι ώρες γραφείου είναι:", result[0][3])
                    except:
                        print("Ο καθηγητής δεν έχει δηλωμένες ώρες γραφείου.")
                except:
                    print("Error")
    except:
        print("Error")
    foithths(AM)
    return

    
def epikalisph(AM): #Συνάρτηση "Ποια μαθήματα επικαλύπτονται μεταξύ τους"
    for k in range(0,6):
        buf="SELECT C.name,D.name FROM (Audience A JOIN Course C on A.course_id=C.id) JOIN (Audience B JOIN Course D on B.course_id=D.id)\
WHERE A.start_time<=B.start_time AND A.end_time>B.start_time AND A.course_id!=B.course_id AND A.day='"+str(k)+"' AND B.day='"+str(k)+"' GROUP BY A.course_id AND B.course_id;"
        try:
            c.execute(buf)
            result=c.fetchall()
            for m in range(len(result)):
                print("Το μάθημα", result[m][0], "επικαλύπτεται με το μάθημα", result[m][1])
        except:
            print("Error")
    foithths(AM)
    return


def programma(AM): #Συνάρτηση εμφάνισης προγράμματος φοιτητή
    days=["Κυριακή", "Δευτέρα", "Τρίτη", "Τετάρτη", "Πέμπτη", "Παρασκευή", "Σάββατο"]
    k=input("Παρακαλώ επέλεξε για ποια ημέρα θα ήθελες να δεις το προγραμμά σου: \n0 --> Κυριακή \n1 --> Δευτέρα \n2 --> Τρίτη \n3 --> Τετάρτη \n4 --> Πέμπτη \n5 --> Παρασκευή \n6-->Σάββατο \n7--> Όλες τις μέρες \n")
    if int(k) not in range(0,8):
        print("Παρακαλώ επέλεξε μία από τις παραπάνω επιλογές. (0-7)")
    else:
        if k=="7": #Αν ο Φοιτητής θέλει να δει το πρόγραμμά του για όλες τις μέρες
            for m in range(0,6):
                buf="select c.name, a.id, au.name, au.building, au.floor, start_time, end_time from Audience as a, Course as c, student_audience as sa,\
audience_auditorium as aa, Auditorium as au where ( (sa.audience_id = a.id and c.id = a.course_id and aa.audience_id=a.id and au.id=aa.auditorium_id) and day='"+str(m)+"' and sa.student_ΑΜ = '"+str(AM)+"');"
                try:
                    c.execute(buf)
                    result=c.fetchall()
                    if len(result)==0:
                        print("Την", days[m], "δεν έχεις μάθημα.")
                    else:
                        print("Την", days[m], "έχεις:")
                        for l in range(len(result)):
                            print(result[l][0], "από τις", result[l][5], "μέχρι τις", result[l][6], "στην αίθουσα", result[l][2], "η οποία βρίσκεται στο κτήριο", result[l][3], "στον όροφο", result[l][4], "\n")
                except:
                    print("Error")
            #Διαφορετική περίπτωση για το Σάββατο για την χρήση σωστού άρθρου
            buf="select c.name, a.id, au.name, au.building, au.floor, start_time, end_time from Audience as a, Course as c, student_audience as sa, audience_auditorium as aa,\
Auditorium as au where ( (sa.audience_id = a.id and c.id = a.course_id and aa.audience_id=a.id and au.id=aa.auditorium_id) and day='"+str(m)+"' and sa.student_ΑΜ = '"+str(AM)+"');"
            try:
                c.execute(buf)
                result=c.fetchall()
                if len(result)==0:
                    print("Το", days[6], "δεν έχεις μάθημα.")
                else:
                    print("Το", days[6], "έχεις:")
                    for l in range(len(result)):
                        print(result[l][0], "από τις", result[l][5], "μέχρι τις", result[l][6], "στην αίθουσα", result[l][2], "η οποία βρίσκεται στο κτήριο", result[l][3], "στον όροφο", result[l][4], "\n")
            except:
                print("Error")
        else: #Αν ο φοιτητής θέλει να δει το πρόγραμμα για μια συγκεκριμένη ημέρα
            buf="select c.name, a.id, au.name, au.building, au.floor, start_time, end_time from Audience as a, Course as c, student_audience as sa, audience_auditorium as aa,\
Auditorium as au where ( (sa.audience_id = a.id and c.id = a.course_id and aa.audience_id=a.id and au.id=aa.auditorium_id) and day='"+str(k)+"' and sa.student_ΑΜ = '"+str(AM)+"');"
            try:
                c.execute(buf)
                result=c.fetchall()
                if len(result)!=0:
                    if k=="6":
                        print("Το Σάββατο έχεις:")
                    else:
                        print("Την", days[int(k)], "έχεις:")
                    for l in range(len(result)):
                        print(result[l][0], "από τις", result[l][5], "μέχρι τις", result[l][6], "στην αίθουσα", result[l][2], "η οποία βρίσκεται στο κτήριο", result[l][3], "στον όροφο", result[l][4], "\n")
                else:
                    print("Δεν έχεις μάθημα αυτή την μέρα.")
            except:
                print("Error")
    foithths(AM)
    return

def eggrafh(AM): #Συνάρτηση εγγραφής/απεγγραφής από ακροατήρια
    epil_foit=input("\nΕπέλεξε: \n1-->Εγγραφή σε μάθημα \n2 --> Απεγγραφή από μάθημα \n")
    if epil_foit=="1": #Εγγραφή
        buf="SELECT Audience.id, Course.name FROM Audience JOIN Course on Audience.course_id=Course.id;"
        try:
            c.execute(buf)
            result = c.fetchall()
            math_list=[]
            print("Τα διαθέσιμα μαθήματα προς εγγραφή είναι:")
            for i in range(len((result))):
                print(result[i])
                math_list.append(result[i][0])
            mathima=input("Πληκτρολόγησε τον κωδικό ακροατηρίου που θα ήθελες να εγγραφείς: \n")
            if mathima not in math_list: #Έλεγχος αν το input είναι κατάλληλο
                print("Παρακαλώ πληκτρολόγησε κατάλληλο κωδικό μαθήματος.")
            else:
                buf="SELECT Audience.id, Course.name, student_audience.student_ΑΜ FROM Course JOIN Audience JOIN student_audience on Course.id=Audience.course_id \
AND Audience.id=student_audience.audience_id WHERE audience_id='"+str(mathima)+"' AND student_ΑΜ='"+str(AM)+"';"
                c.execute(buf)
                result = c.fetchall()
                if len(result)!=1: #Έλεγχος αν ο φοιτητής είναι ήδη γραμμένος στο μάθημα
                    buf="insert into student_audience (audience_id, student_ΑΜ ) SELECT '"+str(mathima)+"', '"+str(AM)+"' WHERE not exists(SELECT * FROM student_audience WHERE audience_id='"+str(mathima)+"' AND student_ΑΜ='"+str(AM)+"');"
                    c.execute(buf)
                    buf="SELECT Audience.id, Course.name FROM Audience JOIN Course on Audience.course_id=Course.id WHERE audience.id='"+str(mathima)+"';"
                    c.execute(buf)
                    conn.commit()
                    result = c.fetchall()
                    print("Μόλις γράφτηκες στο ακροατήριο", result[0][0], "του μαθήματος", result[0][1])
                else:
                    print("Είσαι ήδη γραμμένος στο ακροατήριο", result[0][0], "του μαθήματος", result[0][1])
        except:
                print("Error")
                
    if epil_foit=="2": #Απεγγραφή
        try:
            buf="SELECT audience_id, name FROM student_audience JOIN Audience JOIN course ON student_audience.audience_id=Audience.id AND Audience.course_id=Course.id WHERE student_ΑΜ='"+str(AM)+"';"
            c.execute(buf)
            result = c.fetchall()
            math_list=[]
            print("Είσαι εγγεγραμμένος στα παρακάτω ακροατήρια: \n")
            for i in range(len((result))):
                print(result[i])
                math_list.append(result[i][0])
            mathima_id=input("Πληκτρολόγησε τον κωδικό ακροατηρίου από το οποίο θα ήθελες να απεγγραφείς: \n")
            if mathima_id not in math_list: #Έλεγχος αν το input είναι κατάλληλο
                print("Παρακαλώ πληκτρολόγησε κάποιον από τους παραπάνω κωδικούς μαθήματος.")
            else:
                buf="delete from student_audience where student_ΑΜ = '"+str(AM)+"' and audience_id='"+str(mathima_id)+"';"
                c.execute(buf)
                conn.commit()
                print("Η διαδικασία ολοκληρώθηκε. \n")
                buf="SELECT audience_id, name FROM student_audience JOIN Audience JOIN course ON student_audience.audience_id=Audience.id AND Audience.course_id=Course.id WHERE student_ΑΜ='"+str(AM)+"';"
                c.execute(buf)
                result = c.fetchall()
                print("Είσαι εγγεγραμμένος στα παρακάτω ακροατήρια: \n")
                for i in range(len((result))):
                    print(result[i])
        except:
                print("Error")
    foithths(AM)
    return
        

#Συναρτήσεις Καθηγητή

def ka8hghths(username):
    #Επιλογή λειτουργίας
    epilogh_ka8hghth=input("\nΕπιλέξτε λειτουργία: \n1 --> Εύρεση διαθεσιμότητας φοιτητών \n2 --> Εύρεση διαθέσιμης αίθουσας \n3 --> Αλλαγή διδάσκοντα ακροατηρίου \n")
    while True:
        if epilogh_ka8hghth=="1":
            dia8esimothta_foithtwn(username)
        elif epilogh_ka8hghth=="2":
            dia8esimothta_ai8ousas(username)
        elif epilogh_ka8hghth=="3":
            allagh_didaskonta(username)
        elif epilogh_ka8hghth==" ":
            print("Επιστροφή στην αρχική σελίδα.")
            main()
        else:
            print("Παρακαλώ δώστε κατάλληλο input\n")
            ka8hghths(username)
        break

def dia8esimothta_foithtwn(username):
    buf="SELECT Audience.id, Course.name, Professor.id, Professor.fname, Professor.lname FROM Audience JOIN Course on Audience.course_id=Course.id \
JOIN professor_audience on professor_audience.audience_id=Audience.id JOIN Professor on Professor.Id=professor_audience.professor_id WHERE Professor.Id='"+str(username)+"';"
    try:
        c.execute(buf) #Προβολή ακροατηρίων στα οποία ο συνδεδεμένος καθηγητής είναι υπεύθυνος
        result = c.fetchall()
        print("Είστε διδάσκων στα ακροατήρια:")
        check_akroat=[]
        for i in range(len(result)):
            print(result[i][0], "του μαθήματος", result[i][1])
            check_akroat.append(result[i][0])
        akroat=input("Πληκτρολογήστε τον κωδικό ακροατηρίου για το οποίο θα θέλατε να κάνετε αναζήτηση: \n")
        if akroat not in check_akroat:
            print("Παρακαλώ επιλέξτε έναν κατάλληλο κωδικό ακροατηρίου.")
        else:
            d=input("Θα ήθελα να δω τη διαθεσιμότητα του ακροατηρίου την μέρα: \n0 --> Κυριακή \n1 --> Δευτέρα \n2 --> Τρίτη \n3 --> Τετάρτη \n4 --> Πέμπτη \n5 --> Παρασκευή \n6-->Σάββατο \n")
            if int(d) not in range(0,7):
                print("Παρακαλώ επιλέξτε κατάλληλη ημέρα.")
            else:
                a=int(input("Από τις: (Σε μορφή 0-24) \n"))
                b=int(input("Μέχρι τις: (Σε μορφή 0-24) \n"))
                if (a not in range (0,25)) or (b not in range (0,25)):
                    print("Παρακαλώ πληκτρολογήστε κατάλληλο αριθμό ωρών.")
                else:
                    buf="select count(student_ΑΜ) from student_audience where audience_id = '"+str(akroat)+"' and student_ΑΜ in (select student_ΑΜ from student_audience, Audience \
where student_audience.audience_id = Audience.id except select student_ΑΜ from student_audience, Audience where student_audience.audience_id = Audience.id and day='"+str(d)+"' \
and (((strftime('%H',start_time)>='"+str(a)+"' AND strftime('%H',start_time)<='"+str(b)+"') OR (strftime('%H',end_time)>'"+str(a)+"' AND strftime('%H',end_time)<'"+str(b)+"')) OR (strftime('%H',start_time)<='"+str(a)+"' AND strftime('%H',end_time)>='"+str(b)+"')))"
                    c.execute(buf)
                    result = c.fetchall()
                    print("Τις ώρες που επιλέξατε από το ακροατήριο", akroat, "είναι διαθέσιμοι", result[0][0], "φοιτητές.")
    except:
        print("Error")
    ka8hghths(username)
    return
    

def dia8esimothta_ai8ousas(username): #Αναζήτηση διαθέσιμων αιθουσών για συγκεκριμένες ώρες τις βδομάδας
    d=int(input("Παρακαλώ επιλέξτε ποια ημέρα θα θέλατε να αναζητήσετε διαθέσιμη αίθουσα: \n0 --> Κυριακή \n1 --> Δευτέρα \n2 --> Τρίτη \n3 --> Τετάρτη \n4 --> Πέμπτη \n5 --> Παρασκευή \n6-->Σάββατο \n"))
    if d not in range (0,7):
                    print("Παρακαλώ πληκτρολογήστε κατάλληλο αριθμό ημέρας.")
    a=int(input("Θα ήθελα διαθέσιμη αίθουσα από τις: (Σε μορφή 0-24) \n"))
    b=int(input("Μέχρι τις: (Σε μορφή 0-24) \n"))
    if (a not in range (0,25)) or (b not in range (0,25)):
        print("Παρακαλώ πληκτρολογήστε κατάλληλο αριθμό ωρών.")
    else:        
        buf="SELECT * FROM Auditorium WHERE id NOT IN(SELECT Auditorium.id FROM Auditorium JOIN audience_auditorium on auditorium_id=Auditorium.id \
JOIN Audience on audience_id=Audience.id WHERE Audience.day='"+str(d)+"' AND ((strftime('%H',start_time)>='"+str(a)+"'AND strftime('%H',start_time)<='"+str(d)+"') \
OR (strftime('%H',end_time)>'"+str(a)+"' AND strftime('%H',end_time)<'"+str(b)+"')) OR (strftime('%H',start_time)<='"+str(a)+"' AND strftime('%H',end_time)>'"+str(b)+"'));"
        try:
            c.execute(buf)
            result = c.fetchall()
            print("Οι διαθέσιμες αίθουσες εκείνες τις ώρες είναι:")
            for i in range(len(result)):
                print("Αίθουσα", result[i][1], "στο κτήριο", result[i][2], "στον όροφο", result[i][3])
        except:
            print("Error")
    ka8hghths(username)
    return

    

def allagh_didaskonta(username): #Αλλαγή/Update του διδάσκοντα ενός ακροατηρίου
    buf="SELECT Audience.id, Course.name, Professor.id, Professor.fname, Professor.lname FROM Audience JOIN Course on Audience.course_id=Course.id \
JOIN professor_audience on professor_audience.audience_id=Audience.id JOIN Professor on Professor.Id=professor_audience.professor_id;"
    try:
        c.execute(buf)
        result = c.fetchall()
        print("Αυτή τη στιγμή διδάσκοντες στα ακροατήρια είναι οι:")
        check_akroat=[]
        check_proff=[]
        for i in range(len(result)):
            print(result[i][3], result[i][4], "με κωδικό ID", result[i][2], "στο ακροατήριο", result[i][0], "του μαθήματος", result[i][1])
            check_akroat.append(result[i][0])
            check_proff.append(result[i][2])
        akroat=input("\nΕπιλέξτε σε ποιο ακροατήριο θα θέλατε να αλλάξετε τον διδάσκοντα. Πληκτρολογήστε τον κωδικό του ακροατηρίου. \n")
        if akroat not in check_akroat: #Έλεγχος αν το input είναι κατάλληλο
            print("Παρακαλώ πληκτρολογήστε κατάλληλο κωδικό ακροατηρίου.")
        else:
            new_proff=input("Πληκτρολογήστε τον κωδικό ID του διδάσκοντα που θα διδάσκει πλέον αυτό το ακροατήριο: \n")
            if new_proff not in check_proff: #Έλεγχος αν το input είναι κατάλληλο
                print("Παρακαλώ πληκτρολογήστε κατάλληλο κωδικό διδάσκοντα.")
            else:
                buf="SELECT professor_id FROM professor_audience WHERE audience_id='"+str(akroat)+"';"
                c.execute(buf)
                result = c.fetchall()
                if result[0][0]==str(new_proff):
                    print("Ο καθηγητής αυτός ειναι ήδη υπέυθυνος για το ακροατήριο", akroat)
                else:
                    buf="UPDATE professor_audience SET professor_id='"+str(new_proff)+"' WHERE audience_id='"+str(akroat)+"';"
                    c.execute(buf)
                    conn.commit()
                    print("Η διαδικασία ολοκληρώθηκε. \n")
                    buf="SELECT Audience.id, Course.name, Professor.id, Professor.fname, Professor.lname FROM Audience JOIN Course on Audience.course_id=Course.id \
JOIN professor_audience on professor_audience.audience_id=Audience.id JOIN Professor on Professor.Id=professor_audience.professor_id WHERE Audience.id='"+str(akroat)+"';"
                    c.execute(buf)
                    result = c.fetchall()
                    print("Το ακροατήριο", result[0][0], "έχει νέο διδάσκοντα τον", result[0][3], result[0][4])
    except:
        print("Error")
    ka8hghths(username)
    return


 
#Main

print("\nΚαλώς ορίσατε!")

def main(): #Επιλογή εισόδου, διαφορετικές συναρτήσεις για φοιτητή ή καθηγητή
    x=0
    while x!=" ":
        x=input("\nΕπιλογή εισόδου: \n1 --> Είσοδος Φοιτητή \n2 --> Είσοδος Καθηγητή \n")
        if x=="1":
            login_foithths()
        elif x=="2":
            login_ka8hghths()
        elif x==" ":
            print("Έξοδος προγράμματος")
            return
        else:
            print("Παρακαλώ δώσε κατάλληλο input\n")
            main()
        break
        return

main()
data = c.fetchall();	
conn.close();
