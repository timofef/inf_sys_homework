import json
from flask import Flask, render_template, request, redirect, url_for, session

with open('data_files/menu_config.json', 'r') as conf:
    main_menu = json.load(conf)
with open('data_files/db_config.json', 'r') as db:
    dbconfig = json.load(db)
with open('data_files/point_access.json', encoding='utf-8') as f:
    point_access_items = json.load(f)

app = Flask(__name__)
app.secret_key = "BRUH"
app.config['dbconfig'] = dbconfig
app.config['point_access'] = point_access_items

# Страница авторизации
from auth.auth import auth_blueprint

app.register_blueprint(auth_blueprint, url_prefix='/auth')

# Меню запросов
from queries.queries import queries_blueprint
app.register_blueprint(queries_blueprint, url_prefix='/queries')

# Запросы в бд
from queries.query1.query1 import query1_blueprint
app.register_blueprint(query1_blueprint, url_prefix='/query1')

from queries.query2.query2 import query2_blueprint
app.register_blueprint(query2_blueprint, url_prefix='/query2')

from queries.query3.query3 import query3_blueprint
app.register_blueprint(query3_blueprint, url_prefix='/query3')

from queries.query4.query4 import query4_blueprint
app.register_blueprint(query4_blueprint, url_prefix='/query4')

from queries.query5.query5 import query5_blueprint
app.register_blueprint(query5_blueprint, url_prefix='/query5')

from queries.query6.query6 import query6_blueprint
app.register_blueprint(query6_blueprint, url_prefix='/query6')

# Создание отчета за период
from create_report.create_report import create_report_blueprint
app.register_blueprint(create_report_blueprint, url_prefix='/create_report')

# Просмотр отчета за период
from view_report.view_report import view_report_blueprint
app.register_blueprint(view_report_blueprint, url_prefix='/view_report')

# Создание накладной
from create_delivery_note.create_delivery_note import create_delivery_note_blueprint
app.register_blueprint(create_delivery_note_blueprint, url_prefix='/create_delivery_note')


@app.route('/menu/')
def menu():
    if 'user_group' not in session:
        session['user_group'] = 'Guest'

    route_mapping = {'1': url_for('auth_blueprint.authorization'),
                     '2': url_for('queries_blueprint.queries'),
                     '3': url_for('create_report_blueprint.create_report'),
                     '4': url_for('view_report_blueprint.view_report'),
                     '5': url_for('create_delivery_note_blueprint.create_delivery_note'),
                     }
    point = request.args.get('point')
    if point is None:
        return render_template('main_menu.html', menu=main_menu, user_group=session['user_group'])
    elif point in route_mapping:
        print(route_mapping[point])
        return redirect(route_mapping[point])
    else:
        session['user_group'] = 'Guest'
        return render_template('main_menu.html', menu=main_menu, user_group=session['user_group'])


app.run(host='127.0.0.1', port=5001, debug=True)
