import mariadb

config = {
    'user': 'root',
    'password': 'admin',
    'host': '127.0.0.1',
    'port': 3307
}

def create_connection():
    try:
        conn = mariadb.connect(**config)
        print("Подключение к базе данных MariaDB прошло успешно")
        return conn
    except Exception as e:
        print("Произошла ошибка подключения:")
        print(e)
        return None

def close_connection(conn):
    conn.close()
    print("Соединение закрыто")

if __name__ == '__main__':
    conn = create_connection()
    if conn:
        with conn.cursor() as cursor:
            cursor.execute("CREATE DATABASE IF NOT EXISTS blog;")
            conn.commit()
        close_connection(conn)
