from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app

query1_blueprint = Blueprint('query1_blueprint', __name__, template_folder='templates')


@query1_blueprint.route('/', methods=['GET', 'POST'])
def check():
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        SQL = """SELECT surname, COUNT(delivery_id), SUM(weight)
              FROM personal JOIN delivery_note USING(personal_id)
              WHERE MONTH(delivery_date)=3 AND YEAR(delivery_date)=2017
              GROUP BY surname"""
        cursor.execute(SQL)
        result = cursor.fetchall()
        res = []
        schema = ['surname', 'trans_num', 'total_weight']
        for row in result:
            res.append(dict(zip(schema, row)))
        return render_template('results1.html', rows=res)
