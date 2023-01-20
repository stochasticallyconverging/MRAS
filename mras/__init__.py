import os

from flask import Flask


def create_app(test_config=None):
    # create and configure the app
    # instance_relative_config tells the app that config files are relative to instance folder
    # The instance foler is located outside the MRSA package and can hold data that shouldn't be
    # committed to version control, such as config secrets and the database file.
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',  # Override with random value when deploying
        DATABASE=os.path.join(app.instance_path, 'mras.sqlite')  # path where SQLite db file will be saved
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return 'Hello, World!'

    from . import db
    db.init_app(app)

    from . import auth
    app.register_blueprint(auth.bp)

    return app
