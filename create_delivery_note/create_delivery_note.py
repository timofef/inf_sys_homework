from DBCM import UseDatabase
from flask import render_template, Blueprint, current_app, request, session
from check_auth import check_access
import json

create_delivery_note_blueprint = Blueprint('create_delivery_note_blueprint', __name__, template_folder='templates')


@create_delivery_note_blueprint.route('/', methods=['GET', 'POST'])
@check_access("5")
def create_delivery_note():
    if 'form' not in session:
        session['form'] = []
    with UseDatabase(current_app.config['dbconfig']["Manager"]) as cursor:
        options = show_options(cursor)
        if 'send' in request.form and request.form['send'] == "Сформировать":
            delivery_date = request.form.get('date')
            driver_id = request.form.get('driver')
            client_id = request.form.get('client')
            transport_id = request.form.get('transport')
            amount = request.form.get('amount')
            weight = request.form.get('weight')

            if check_form(delivery_date, driver_id, client_id, transport_id, amount, weight):
                return render_template('create_delivery_note_form.html', form=session['form'], options=options, is_filled=0)

            driver = {"driver_id": driver_id,
                      "driver_name": get_name_from_options(options, driver_id, 'driver')}
            client = {"client_id": client_id,
                      "client_name": get_name_from_options(options, client_id, 'client')}
            transport = {"transport_id": transport_id,
                         "transport_name": get_name_from_options(options, transport_id, 'transport')}

            save_form(delivery_date, driver, client, transport, amount, weight)
            return render_template('create_delivery_note_view.html', form=session['form'])

        elif 'create_note' in request.form and request.form['create_note'] == "Подтвердить":
            print("\n\nADDED\n\n")
            save_into_db(cursor)
            return render_template('create_delivery_note_result.html')

        elif 'edit_note' in request.form and request.form['edit_note'] == "Изменить":
            return render_template('create_delivery_note_form.html', form=session['form'], options=options, is_filled=1)

        elif 'cancel' in request.form and request.form['cancel'] == "Отмена":
            session['form'].clear()
            return render_template('create_delivery_note_form.html', form=session['form'], options=options, is_filled=1)

        else:
            return render_template('create_delivery_note_form.html', form=session['form'], options=options, is_filled=1)


def show_options(cursor):
    options = {
        "driver": get_drivers(cursor),
        "client": get_clients(cursor),
        "transport": get_transport(cursor)
    }
    return options


def get_drivers(cursor):
    SQL = f"""SELECT personal_id, surname
                  FROM personal"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['driver_id', 'name']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res


def get_clients(cursor):
    SQL = f"""SELECT client_id, client_name
                      FROM client"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['client_id', 'name']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res


def get_transport(cursor):
    SQL = f"""SELECT transport_id, brand
                      FROM transport"""
    cursor.execute(SQL)
    result = cursor.fetchall()
    res = []
    schema = ['transport_id', 'name']
    for row in result:
        res.append(dict(zip(schema, row)))
    return res


def get_name_from_options(options, id, category):
    for item in options[category]:
        if item[category +"_id"] == int(id):
            return item['name']


def check_form(*args):
    for field in args:
        if not field:
            return 1
    return 0


def save_form(delivery_date, driver, client, transport, amount, weight):
    session['form'].clear()
    session['form'] = [{
        "amount": int(amount),
        "weight": int(weight),
        "delivery_date": delivery_date,
        "delivery_cost": int(0),
        "driver_id": int(driver["driver_id"]),
        "client_id": int(client["client_id"]),
        "transport_id": int(transport["transport_id"]),
        "driver_name": driver["driver_name"],
        "client_name": client["client_name"],
        "transport_name": transport["transport_name"],

    }]


def save_into_db(cursor):
    SQL = f"""INSERT INTO delivery_note
    	         VALUES (NULL, %s, %s, %s, %s, %s, %s, %s,)"""
    values = session['form'][0].values()
    values = list(values)
    cursor.execute(SQL, (values[0], values[1], values[2], values[3], values[4], values[5], values[6]))
    return
