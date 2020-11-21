from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app

query3_blueprint = Blueprint('query3_blueprint', __name__, template_folder='templates')


@query3_blueprint.route('/', methods=['GET', 'POST'])
def check():
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        SQL = """SELECT *
              FROM client
              WHERE client_id in (select client_id
                                  from client join (select * from reestr where reestr_year=YEAR(CURDATE())) r  USING(client_id)
                                  where weight_sum = (SELECT MAX(weight_sum) FROM reestr WHERE reestr_year=YEAR(CURDATE())))"""
        cursor.execute(SQL)
        result = cursor.fetchall()
        res = []
        schema = ['client_id', 'client_name', 'address', 'district', 'contact', 'phone']
        for row in result:
            res.append(dict(zip(schema, row)))
        return render_template('results3.html', rows=res)
