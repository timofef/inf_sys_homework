from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app, request
from check_auth import check_access

create_report_blueprint = Blueprint('create_report_blueprint', __name__, template_folder='templates')


@create_report_blueprint.route('/', methods=['GET', 'POST'])
@check_access("3")
def create_report():
    if 'send' in request.form and request.form['send'] == 'send':
        data = request.form.get('year')
        if data:
            with UseDatabase(current_app.config['dbconfig']["Director"]) as cursor:
                exists = check(cursor, data)
                execute_proc(cursor, data)
                res = execute_query(cursor, data)
            return render_template('create_result.html', rows=res, year=data, alreadyExisted=exists)
        else:
            return render_template('report_input.html')
    else:
        return render_template('report_input.html')


def execute_query(cursor, data):
    SQL = f"""SELECT client_name, deliveries_sum, avg_weight, avg_cost, report_year
                  FROM client JOIN year_report USING(client_id)
                  WHERE report_year = {data}"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['client_name', 'deliveries_sum', 'avg_weight', 'avg_cost', 'report_year']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res


def execute_proc(cursor, r_year):
    arg = [r_year]
    cursor.callproc('create_report', arg)


def check(cursor, r_year):
    SQL = f"""Select count(*) from year_report
              where report_year= {r_year}"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    a = result[0][0]
    return a