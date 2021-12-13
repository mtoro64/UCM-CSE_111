from flask import Flask, render_template, request
import sqlite3
from sqlite3 import Error

app = Flask(__name__)

# For the Home Page
@app.route('/')
def init():
    return render_template('index.html')

# For the Home Page
@app.route('/Home')
def home():
    return render_template('index.html')
   
# For the Attachments page
@app.route('/Attachments')
def attach():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT Attach_Name, Attach_Desc FROM Attachments"""
    cur = conn.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    return render_template('Attachments.html', data = data)

# For the Killstreaks page
@app.route('/KillStreaks')
def streaks():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT KillStreak_Name, KillStreak_Points, KillStreak_Desc FROM Kill_Streaks"""
    cur = conn.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    return render_template('KillStreaks.html', data = data)

# For the Maps page
@app.route('/Maps')
def map():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT Maps_Name FROM Maps"""
    cur = conn.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    return render_template('Maps.html', data = data)

@app.route('/mapsize', methods = ['POST',"GET"])
def mapsize():
    results = request.form['map']
    print(results)
    database = r"BO2.sqlite"
    conn = openConnection(database)
    _conn = conn.cursor()
    sql = """SELECT Maps_Name, Maps_Size, Maps_Location FROM Maps WHERE Maps_Size  = ?"""
    args = [results]
    _conn.execute(sql, args)
    query = _conn.fetchall()
    print(query)
    _conn.execute("SELECT Maps_Name, Maps_Size, Maps_Location FROM Maps")
    data = _conn.fetchall()


    return render_template("Maps.html",Rec = query, data = data, name = results)


# For the Perks page
@app.route('/Perks')
def perk():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT Perk_Name, Perk_Type, Perk_Desc FROM Perks"""
    cur = conn.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    return render_template('Perks.html', data = data)


# For the Throwables page
@app.route('/Throwables')
def throw():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT * FROM Throwables"""
    cur = conn.cursor()
    cur.execute(sql)
    data2 = cur.fetchall()
    return render_template('Throwables.html', data = data2)


# For the Weapons Page
@app.route('/Weapons')
def weapons():
    conn = sqlite3.connect(r"BO2.sqlite")
    sql = """SELECT Weapon_Name FROM Weapons"""
    cur = conn.cursor()
    cur.execute(sql)
    data2 = cur.fetchall()
    return render_template('Weapons.html', data = data2)

# for the Weapon Type
@app.route('/WeaponType', methods = ['POST',"GET"])
def WeaponCategory():
    results = request.form['TWeapon']
    print(results)
    database = r"BO2.sqlite"
    conn = openConnection(database)
    _conn = conn.cursor()
    sql = """
            SELECT Weapon_Name, Weapon_Type, Weapon_Category
            FROM Weapons 
            WHERE Weapon_Type  = ?
            """
    args = [results]
    _conn.execute(sql, args)
    query = _conn.fetchall()
    print(query)
    _conn.execute("SELECT Weapon_Name, Weapon_Type, Weapon_Category FROM Weapons")
    data = _conn.fetchall()

    return render_template("Weapons.html",Rec = query, data = data, name = results)

#for the Weapon Types


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

# Keeps refreshing the page when the code has been updated
if __name__ == "__main__": 
    app.run(debug=True)