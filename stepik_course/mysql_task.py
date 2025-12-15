import mariadb

config = {
    'user': 'root',
    'password': 'admin',
    'host': '127.0.0.1',
    'port': 3306,
    # 'database': 'blog'
}


def create_connection():
    connection = None
    try:
        connection = mariadb.connect(**config)
        print("Подключение к базе данных PostgreSQL прошло успешно")
    except Exception as e:
        print(f"Произошла ошибка:\n{e}")
    return connection


def close_connection(connection):
    connection.close()
    print("Соединение закрыто")


if __name__ == '__main__':
    conn = create_connection()
    if conn:
        with conn.cursor() as cursor:
            sql = "CREATE DATABASE blog;"
            cursor.execute(sql)
            conn.commit()
        close_connection(conn)