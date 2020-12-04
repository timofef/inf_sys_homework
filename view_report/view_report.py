from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app, request
from auth.auth import check_access

view_report_blueprint = Blueprint('view_report_blueprint', __name__, template_folder='templates')


@view_report_blueprint.route('/', methods=['GET', 'POST'])
@check_access("4")
def view_report():
    if 'send' in request.form and request.form['send'] == 'send':
        data = request.form.get('year')
        if data:
            with UseDatabase(current_app.config['dbconfig']["Director"]) as cursor:
                res = execute_query(cursor, data)
            return render_template('view_report_result.html', rows=res, year=data)
        else:
            return render_template('view_report_input.html')
    else:
        return render_template('view_report_input.html')


def execute_query(cursor, data):
    SQL = f"""SELECT client_name, deliveries_sum, avg_weight, avg_cost, report_year
                  FROM client JOIN year_report USING(client_id)
                  WHERE report_year =  {data}"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['client_name', 'deliveries_sum', 'avg_weight', 'avg_cost', 'report_year']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res