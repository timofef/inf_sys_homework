import mysql.connector


class ConnectionError(Exception):
    pass


class CredentionalError(Exception):
    pass


class BaseError(Exception):
    pass


class UseDatabase:

    def __init__(self, config: dict):
        self.configuration = config

    def __enter__(self):
        try:
            self.conn = mysql.connector.connect(**self.configuration)
            self.cursor = self.conn.cursor()
            return self.cursor
        except mysql.connector.errors.InterfaceError as err:
            raise ConnectionError(err)
        except mysql.connector.errors.ProgrammingError as err:
            raise CredentionalError(err)
        except mysql.connector.errors.DatabaseError as err:
            raise BaseError(err)

    def __exit__(self, exc_type, exc_value, exec_trace):
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
