from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app

query4_blueprint = Blueprint('query4_blueprint', __name__, template_folder='templates')


@query4_blueprint.route('/', methods=['GET', 'POST'])
def check():
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        SQL = """SELECT surname, addr
              FROM personal LEFT JOIN delivery_note USING(personal_id)
              WHERE delivery_id IS NULL"""
        cursor.execute(SQL)
        result = cursor.fetchall()
        res = []
        schema = ['surname', 'addr']
        for row in result:
            res.append(dict(zip(schema, row)))
        return render_template('results4.html', rows=res)
