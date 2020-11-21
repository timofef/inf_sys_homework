from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app, request

query2_blueprint = Blueprint('query2_blueprint', __name__, template_folder='templates')


@query2_blueprint.route('/', methods=['GET', 'POST'])
def check():
    if 'send' in request.form and request.form['send'] == 'send':
        data = request.form.get('client')
        if data:
            with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
                res = execute_query(cursor, data)
            return render_template('results2.html', client=data, rows=res)
        else:
            return render_template('input.html')
    else:
        return render_template('input.html')


def execute_query(cursor, data):
    SQL = f"""SELECT surname, delivery_date
                  FROM (SELECT * FROM personal JOIN delivery_note USING(personal_id)) per JOIN client USING(client_id)
                  WHERE client_id = {data}"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['surname', 'delivery_date']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res
