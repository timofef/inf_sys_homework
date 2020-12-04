from functools import wraps
from flask import Blueprint, redirect, render_template, session, request, current_app
from DBCM import UseDatabase

auth_blueprint = Blueprint('auth_blueprint', __name__, template_folder='templates')


@auth_blueprint.route('/', methods=['GET', 'POST'])
def authorization():
    if 'send' in request.form and request.form['send'] == 'auth':
        result = []
        login = request.form.get('login')
        password = request.form.get('password')
        print(login)
        print(password)
        if login and password:
            with UseDatabase(current_app.config['dbconfig']['Guest']) as cursor:
                cursor.execute("""SELECT role 
                                  FROM curs.user_groups
                                  WHERE login='%s'
                                  AND password='%s'""" % (login, password))
                schema = ['user_group']
                for con in cursor.fetchall():
                    result.append(dict(zip(schema, con)))
            if len(result) > 0:
                session['user_group'] = result[0]['user_group']
                return redirect('/menu')
            else:
                return render_template('auth.html', status=1)
    else:
        return render_template('auth.html', status=0)


def check_access(point):
    def _check_access(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            role_mapping = current_app.config['point_access']
            if session['user_group'] not in role_mapping[point]:
                return render_template('access_denied.html', needed=" или ".join(role_mapping[point]))
            else:
                return func(*args, **kwargs)
        return wrapper
    return _check_access
