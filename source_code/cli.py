import subprocess as sp
import pymysql
import pymysql.cursors
from datetime import datetime
import time
import secrets
from tabulate import tabulate 

def pretty_table(data):
    if data:
        headers = data[0].keys()
        rows = [list(row.values()) for row in data]
        table = tabulate(rows, headers, tablefmt="pretty")
        print(table)
    else:
        print("No data found for the given user.")

def generate_timestamp_hash(length):
    timestamp_part = str(int(time.time()))

    input_data = timestamp_part + secrets.token_urlsafe(16)

    hashed_data = secrets.token_hex(length)

    return hashed_data

def generate_mysql_timestamp():
    current_datetime = datetime.now()

    mysql_timestamp = current_datetime.strftime('%Y-%m-%d %H:%M:%S')

    return mysql_timestamp

def insert_users():
    try:
        row = {}
        row["Username"] = input("Username: ")
        row["avatar"] = None
        row["Mail_address"] = input("Mail: ")
        row["Creation_Time"] = generate_mysql_timestamp()
        row["No_of_wallets"] = 0
        query="INSERT INTO Crypto_User ( Username,Avatar,Mail_Address,Creation_Time,No_of_Wallets)VALUES('%s',%s,'%s','%s', %d)"%( row["Username"], "NULL", row["Mail_address"], row["Creation_Time"],row["No_of_wallets"])
        curr.execute(query)
        con.commit()

    except Exception as e:
        print(e)
        exit()

def insert_wallets():
    try:
        row = {}
        row["Wallet_Address"] = generate_timestamp_hash(10)
        row["Balance"] = 0
        row["Public_Key"] = generate_timestamp_hash(10)
        row["Creation_Time"] = generate_mysql_timestamp()
        row["owner_wallet"] = int(input("Owner of the Wallet: "))
        row["Security_Feature"] = input("Security Feature: ")
        row["Wallet_Status"] = "Active"

        query = "INSERT INTO Wallet ( Wallet_Address, Balance, Public_Key, Creation_Time, owner_wallet, Security_Feature, Wallet_Status)VALUES('%s', %d, '%s', '%s', %d, '%s', '%s')" %(row["Wallet_Address"], row["Balance"], row["Public_Key"], row["Creation_Time"], row["owner_wallet"], row["Security_Feature"], row["Wallet_Status"])

        curr.execute(query)

        query = f"UPDATE Crypto_User SET No_of_Wallets = No_of_Wallets + 1 WHERE User_id = {row['owner_wallet']}"
        curr.execute(query)

        con.commit()

    except Exception as e:
        print(e)
        exit()

def insert_mining_machine():
    try:
        row={}
        lat_long = list(map(float, input("Coordinates: ").split(" ")))
        print(lat_long)
        row["Coordinates"] = lat_long
        row["Model"]=input("Model: ")
        query = f"SELECT * FROM Model_MM WHERE Model = '{row['Model']}'"
        curr.execute(query)
        data = curr.fetchall()
        if len(data) == 0:
            row["Computational_power"] = float(input("Computational Power: "))
            row["Energy_Consumption"] = float(input("Energy Consumption: "))
            query = "INSERT INTO Model_MM(Model, Energy_Consumption, Computational_Power) VALUES('%s', '%f', '%f');" %(row["Model"], row["Energy_Consumption"], row["Computational_power"])
            curr.execute(query)
        print("queruy")
        query = "INSERT INTO Model_MM"
        row["Operating_Status"] = "Active"
        row["Associated_wallet"] = input("Assoc. Wallet Address: ")
        row["Operational_Time"] = int(input("Operational Time: "))
        row["owner_machine"] = int(input("Owner user_id:"))
        query = "INSERT INTO Mining_Machine(Coordinates_Latitude, Coordinates_Longitude, Model, Operational_Time, Operating_Status, Associated_Wallet, owner_machine) VALUES('%f', '%f', '%s', '%d', '%s', '%s', '%d')"%(lat_long[0],lat_long[1], row["Model"], row["Operational_Time"], row["Operating_Status"], row["Associated_wallet"], row["owner_machine"])
        print(query)
        curr.execute(query)
        con.commit()

    except Exception as e:
        print(e)
        exit()
def insert():
    try:
        print("1:INSERT INTO CRYPTO_USERS")
        print("2:INSERT INTO WALLET")
        print("3:INSERT INTO MINNING MACIHNE")
        print("4: Go Back")
        var=int(input())
        if var==1:
            insert_users()
        if var==2:
            insert_wallets()
        if var==3:
            insert_mining_machine()
        else:
            init()
    except Exception as e:
        print(e)
        exit()


def delete():
    print("""
        1. Delete User from Crypto_users
        2. Delete Wallet from Wallets.
        3. Go Back
    """)
    try:
        flag=int(input("> "))
        if flag==1:
            u_id=input("User id: ")
            query=f"DELETE FROM Crypto_User WHERE User_id = {u_id}"
            curr.execute(query)
            con.commit()

        if flag==2:
            u_id=input("Wallet_Address: ")
            
            query = f"SELECT owner_wallet FROM Wallet WHERE Wallet_Address = '{u_id}'"
            curr.execute(query)
            com = curr.fetchone()

            query=f"DELETE FROM Wallet WHERE Wallet_Address LIKE '{u_id}'"            
            curr.execute(query)
            

            query = f"UPDATE Crypto_User SET No_of_Wallets = No_of_Wallets - 1 WHERE User_id = {com['owner_wallet']}"
            curr.execute(query)
            con.commit()
        else:
            init()  
    except Exception as e:
        print(e)
        exit()    

def update():
    print("""
        1. Update Coin Price (Auto)
        2. Update Username
        3. Go Back
    """)
    try:
        flag=int(input("> "))
        if flag==1:
            coin = input("Coin: ")
            new_price = float(input("New Price: "))
            query = f"UPDATE Cryptocoin SET Current_Price={new_price} WHERE Coin_Name='{coin}'"
            print(query)
            curr.execute(query)
            con.commit()
        elif flag==2:
            u_id=int(input("User_id: "))
            var=input("New Username: ")
            query=f"UPDATE Crypto_User SET Username='{var}' WHERE User_id= {u_id}"
            curr.execute(query)
            con.commit()
        else:
            init()
            
    except Exception as e:
        print(e)
        exit()    
            

def retrieve1():
    try:
        user = int(input("User_id: "))
        query = f"SELECT * FROM Mining_Machine WHERE owner_machine={user}"
        curr.execute(query)

        data = curr.fetchall()
        pretty_table(data)
    except Exception as e:
        exit()
def retrieve2():
    try:
        sender = int(input("Sender_id: "))
        crypto = input("Cryptocoin: ")
        query= f"SELECT Receiver_Wallet, Transacted_Amount, Hash_Value FROM Transaction JOIN Wallet ON Sender_Wallet = Wallet.Wallet_Address WHERE owner_wallet = '{sender}' AND Exchanged_Cryptocoin_name = '{crypto}'"
        curr.execute(query)

        data = curr.fetchall()
        pretty_table(data)

    except Exception as e:
        exit()

def projection1():
    try:
        energy_cons=int(input("Energy Threshold: "))
        query=f"SELECT Machine_ID, Coordinates_Latitude, Coordinates_Longitude FROM Mining_Machine JOIN Model_MM ON Model_MM.Model = Mining_Machine.Model WHERE Energy_Consumption > {energy_cons}"
        curr.execute(query)
        
        data=curr.fetchall()
        pretty_table(data)

    except Exception as e:
        exit()

def projection2():
    try:
        giv_price=int(input("Least Price: "))
        query=f"SELECT Abbreviation, Current_Price FROM Cryptocoin WHERE Current_Price > {giv_price}"
        curr.execute(query)
        data=curr.fetchall()
        pretty_table(data)
    except Exception as e:
        print(e)
        exit()

def aggregate1():
    try:
        query="SELECT SUM(Transacted_Amount) FROM Transaction"
        curr.execute(query)
        data=curr.fetchall()
        pretty_table(data)
    except Exception as e:
        exit()

def aggregate2():
    try:
        query="SELECT MAX(royalty) FROM NFT_Creator"
        curr.execute(query)
        data=curr.fetchall()
        pretty_table(data)
    except Exception as e:
        exit()

def partial_search():
    try:
        partial_name=input("User_name (partial): ")
        query=f"SELECT * FROM Crypto_User WHERE Username LIKE '%{partial_name}%'"
        curr.execute(query)
        data=curr.fetchall()
        pretty_table(data)
    except Exception as e:
        exit()

def most_used_crypto():
    try:
        username = input("Username: ")
        query = f"SELECT Inv_CrypCoin, COUNT(Inv_CrypCoin) AS count FROM Crypto_User JOIN Transaction_Users ON sender_id = User_id WHERE Username = '{username}' GROUP BY Inv_CrypCoin ORDER BY count DESC LIMIT 1"

        curr.execute(query)
        data = curr.fetchall()
        pretty_table(data)
        
    except Exception as e:
        exit()

def exchange_rates():
    try:
        crypto1 = input("Cryptocoin 1: ")
        crypto2 = input("Cryptocoin 2: ")
        query = f"SELECT Exchange_Name, Exchange_Ratio, Conversion_Fee FROM Crypto_Exchange JOIN Trading_Pairs ON Exchange_ID = Crypto_Exchange_ID WHERE Cryptocoin_1 = '{crypto1}' AND Cryptocoin_2 = '{crypto2}'"
        curr.execute(query)
        data = curr.fetchall()
        pretty_table(data)

    except Exception as e:
        exit()

def retrieve():
    print("1. SELECT MINNING_DETAILS_OF_USERS")
    print("2. SELECT TRANSACTIONS_OF_USERS")
    print("3. PROJECTING MINNING MACHINES OF GIVEN THRESHOLD")
    print("4. PROJECTING RICH_COINS")
    print("5. AGGREATE:TOTAL_TRANSACTED_CRYPTO_COINS")
    print("6. AGGREAGTE:ROYALITY_RULES")
    print("7. PARTIAL SEARCH")
    var=int(input("> "))
    if var==1:
        retrieve1()
    if var==2:
        retrieve2()
    if var==3:
        projection1()
    if var==4:
        projection2()
    if var==5:
        aggregate1()
    if var==6:
        aggregate2()
    if var==7:
        partial_search()
    else:
        init()

def dispatch(ch):
    try:
        if ch==1:
            insert()
        elif ch==2:
            delete()
        elif ch==3:
            update()
        elif ch==4:
            retrieve()
        elif ch==5:
            Analysis()
        else:
            print("Invalid option")
    except Exception as e:
        print(e)
        exit()

def Analysis():
    print("1. Most Used Cryptocoin")
    print("2. Exchange Rates")
    print("3. Back")

    com = int(input("> "))
    if com == 1:
        most_used_crypto()
    elif com == 2:
        exchange_rates()
    else:
        retrieve()

def init():
    print("1. INSERT")
    print("2. DELETE")
    print("3. UPDATE")
    print("4. RETRIEVE")
    print("5. Analysis")
    print("6. LOGOUT")
    ch=int(input("> "))
    if ch==6:
        exit()
    else:
        dispatch(ch)

while(1):
    username = "root"
    password = "Bunny#mysql69"
    try:
        con = pymysql.connect(host='localhost',
                              port=3306,
                              user=username,
                              password=password,
                              database='crypto',
                              cursorclass=pymysql.cursors.DictCursor)
        # tmp = sp.call('clear', shell=True)
        if(con.open):
            print("connected")
        else:
            print("failed to connect")
        tmp=input("Enter any key to continue>")
        with con.cursor() as curr:
            while(1):
                # tmp=sp.call('clear',shell=True)
                print("1. INSERT")
                print("2. DELETE")
                print("3. UPDATE")
                print("4. RETRIEVE")
                print("5. Analysis")
                print("6. LOGOUT")
                ch=int(input("> "))
                if ch==6:
                    exit()
                else:
                    dispatch(ch)

    except Exception as e:
        # tmp=sp.call('clear',shell=True)
        print(e)
        print("Connection refused")
        ch=int(input("Enter any key:"))