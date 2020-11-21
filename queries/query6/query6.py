from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app

query6_blueprint = Blueprint('query6_blueprint', __name__, template_folder='templates')


@query6_blueprint.route('/', methods=['GET', 'POST'])
def check():
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        SQL = """select * from avg_1_2017
              union select * from avg_2_2017
              union select * from avg_3_2017
              union select * from avg_4_2017
              union select * from avg_5_2017
              union select * from avg_6_2017
              union select * from avg_7_2017
              union select * from avg_8_2017
              union select * from avg_9_2017
              union select * from avg_10_2017
              union select * from avg_11_2017
              union select * from avg_12_2017"""
        cursor.execute(SQL)
        result = cursor.fetchall()
        res = []
        schema = ['num', 'avg_cost']
        for row in result:
            res.append(dict(zip(schema, row)))
        return render_template('results6.html', rows=res)
