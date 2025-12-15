import sqlite3


def create_connection():
    connection = None
    try:
        connection = sqlite3.connect('test.db')
        print("Подключение к базе данных SQLite прошло успешно")
    except Exception as e:
        print(f"Произошла ошибка:\n{e}")
    return connection


def close_connection(connection):
    connection.close()
    print("Соединение закрыто")


if __name__ == '__main__':
    conn = create_connection()
    if conn:
        conn.execute('''CREATE TABLE COMPANY
                 (ID INT PRIMARY KEY     NOT NULL,
                 NAME           TEXT    NOT NULL,
                 AGE            INT     NOT NULL,
                 ADDRESS        CHAR(50),
                 SALARY         REAL);''')
        conn.commit()
    close_connection(conn)