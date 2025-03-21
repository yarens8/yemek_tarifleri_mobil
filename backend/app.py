from flask import Flask, jsonify
from flask_cors import CORS
from database_service import db_service
import logging

app = Flask(__name__)
CORS(app)  # Cross Origin Resource Sharing'i etkinleştir

# Logging yapılandırması
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/')
def index():
    return jsonify({'message': 'API çalışıyor!'})

@app.route('/api/categories')
def get_categories():
    try:
        categories = db_service.get_categories()
        return jsonify(categories)
    except Exception as e:
        logger.error(f"Kategoriler getirilirken hata: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/recipes')
def get_recipes():
    try:
        recipes = db_service.get_recipes()
        return jsonify(recipes)
    except Exception as e:
        logger.error(f"Tarifler getirilirken hata: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/recipes/category/<int:category_id>')
def get_recipes_by_category(category_id):
    try:
        recipes = db_service.get_recipes(category_id=category_id)
        return jsonify(recipes)
    except Exception as e:
        logger.error(f"Kategori tarifleri getirilirken hata: {str(e)}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/recipes/search/<query>')
def search_recipes(query):
    try:
        recipes = db_service.search_recipes(query)
        return jsonify(recipes)
    except Exception as e:
        logger.error(f"Tarif araması yapılırken hata: {str(e)}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # Veritabanı bağlantısını test et
    if db_service.connect():
        logger.info("Veritabanı bağlantısı başarılı, API başlatılıyor...")
        app.run(host='0.0.0.0', port=5000, debug=True)
    else:
        logger.error("Veritabanı bağlantısı başarısız, API başlatılamadı!") 