from flask import Flask, render_template, request, redirect, url_for, Blueprint, session, session
from check_auth import check_access
import json

queries_blueprint = Blueprint('queries_blueprint', __name__, template_folder='templates')

with open('data_files/queries_menu_config.json', 'r') as f:
    queries_menu = json.load(f)


@queries_blueprint.route('/', methods=['POST', 'GET'])
@check_access("2")
def queries():
    route_mapping = {'1': url_for('query1_blueprint.check'),
                     '2': url_for('query2_blueprint.check'),
                     '3': url_for('query3_blueprint.check'),
                     '4': url_for('query4_blueprint.check'),
                     '5': url_for('query5_blueprint.check'),
                     '6': url_for('query6_blueprint.check')
                     }
    query = request.args.get('query')
    if query is None:
        return render_template('query_menu.html', queries=queries_menu)
    elif query in route_mapping:
        return redirect(route_mapping[query])
    else:
        return render_template('query_menu.html', queries=queries_menu)
