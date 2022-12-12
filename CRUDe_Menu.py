import mysql
import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="root",
    database="clearlake_shelter"
    )

mycursor = db.cursor()

inputInvalid = True

print("Welcome to the python text menu for managing the pet shelter database\n")

while True:
    print("Please input the number of your desired action\n 1)- Create - to insert new tables or attributes\n 2)- Read - to search the database\n 3)- Update - to change attributes\n 4)- Delete - to remove attributes or tables\n 5)- Exit - if you wish to quit\n : ")

    userInput = input()
    userInput = userInput.lower()

    if userInput == "1":
        inputInvalid = False
        print('create test')


    if userInput == "2":
        form = input("What would you like to do?\n 1)- List all tables \n 2)- Describe specific table structure \n 3)- Display a table \n : ")
        if form == '1':
            mycursor.execute("Show tables;")
            tables = [item for sublist in mycursor.fetchall() for item in sublist]
            table = ""
            print(tables)
            print("")
        if form == '2':
            inputInvalid = False
            mycursor.execute("Show tables;")
            tables = [item for sublist in mycursor.fetchall() for item in sublist]
            table = ""
            while table not in tables:
                table = input("Enter the table to describe: ")

            mycursor.execute("DESCRIBE %s" % table)
            for item in mycursor:
                print(item)
            print("")
        if form == '3':
            inputInvalid = False
            mycursor.execute("Show tables;")
            tables = [item for sublist in mycursor.fetchall() for item in sublist]
            table = ""
            while table not in tables:
                table = input("Enter the table to search for: ")

            mycursor.execute("SELECT * FROM %s" % table)
            for item in mycursor:
                print(item)
            print("")

    if userInput == "3":
        inputInvalid = False
        print('create test')



    if userInput == "4":
        inputInvalid = False
        form = input("What would you like to delete?\n 1)- Table \n 2)- Specific record \n 3)- Column \n : ")
        print('xd')


    if userInput == "5":
        inputInvalid = False
        print("Exiting text menu")
        exit()

    if inputInvalid:
        print("Invalid input please try again:/n")

    inputInvalid = True
