import psycopg2  


def create_connection():
    connection = None
    try:
        connection = psycopg2.connect(
            database="blog",  # эта БД уже должна быть 
            user='postgres',
            password='admin',
            host='127.0.0.1',
            port='5432',
        )
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
            # sql для выполнения
            sql = "CREATE TABLE users (" \
                  "brand VARCHAR(255), " \
                  "model VARCHAR(255), " \
                  "year INT" \
                  ");"
            # выполнение запроса
            cursor.execute(sql)
            # потверждение выполнения запроса
            conn.commit()
        close_connection(conn)