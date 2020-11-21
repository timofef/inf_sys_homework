from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app

query5_blueprint = Blueprint('query5_blueprint', __name__, template_folder='templates')


@query5_blueprint.route('/', methods=['GET', 'POST'])
def check():
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        SQL = """SELECT surname, addr, birthday, job, emp_date FROM personal LEFT JOIN (SELECT *
              FROM delivery_note WHERE MONTH(delivery_date)=3 AND YEAR(delivery_date)=2017) t
              USING(personal_id) where delivery_id is NULL"""
        cursor.execute(SQL)
        result = cursor.fetchall()
        res = []
        schema = ['surname', 'addr', 'birthday', 'job', 'emp_date']
        for row in result:
            res.append(dict(zip(schema, row)))
        return render_template('results5.html', rows=res)
