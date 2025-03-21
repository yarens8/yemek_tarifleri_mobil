import pyodbc
from database_config import DB_CONFIG
import logging

class DatabaseService:
    def __init__(self):
        self.connection = None
        self.setup_logging()
        
    def setup_logging(self):
        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger(__name__)
        
    def connect(self):
        """Veritabanına bağlantı kurar"""
        try:
            connection_string = (
                "Driver={SQL Server};"
                "Server=.\\SQLEXPRESS;"
                "Database=YemekTarifleri;"
                "Trusted_Connection=yes"
            )
            self.connection = pyodbc.connect(connection_string)
            self.logger.info("Veritabanı bağlantısı başarılı")
            return True
        except Exception as e:
            self.logger.error(f"Veritabanı bağlantı hatası: {str(e)}")
            return False
            
    def disconnect(self):
        """Veritabanı bağlantısını kapatır"""
        if self.connection:
            self.connection.close()
            self.connection = None
            self.logger.info("Veritabanı bağlantısı kapatıldı")
            
    def get_categories(self):
        """Tüm kategorileri getirir"""
        try:
            if not self.connection:
                self.connect()
                
            cursor = self.connection.cursor()
            cursor.execute("SELECT id, name FROM dbo.Category")
            categories = []
            
            for row in cursor.fetchall():
                category = {
                    'id': row[0],
                    'name': row[1],
                    'description': ''  # Bu tabloda description sütunu yok
                }
                categories.append(category)
            
            return categories
        except Exception as e:
            self.logger.error(f"Kategoriler getirilirken hata: {str(e)}")
            raise Exception(f"Kategoriler yüklenirken hata: {str(e)}")
            
    def get_recipes(self, category_id=None):
        """Tüm tarifleri veya belirli bir kategoriye ait tarifleri getirir"""
        try:
            if not self.connection:
                self.connect()
                
            cursor = self.connection.cursor()
            
            if category_id:
                query = """
                    SELECT [id], [title], [ingredients], [instructions], [created_at],
                           [user_id], [category_id], [views], [serving_size],
                           [preparation_time], [cooking_time], [tips], [image_filename],
                           [ingredients_sections], [username]
                    FROM dbo.Recipe 
                    WHERE [category_id] = ?
                """
                cursor.execute(query, category_id)
            else:
                query = """
                    SELECT [id], [title], [ingredients], [instructions], [created_at],
                           [user_id], [category_id], [views], [serving_size],
                           [preparation_time], [cooking_time], [tips], [image_filename],
                           [ingredients_sections], [username]
                    FROM dbo.Recipe
                """
                cursor.execute(query)
                
            recipes = []
            for row in cursor.fetchall():
                recipe = {
                    'id': row[0],
                    'title': row[1],
                    'ingredients': row[2] if row[2] else '',
                    'instructions': row[3] if row[3] else '',
                    'created_at': row[4].strftime('%Y-%m-%d') if row[4] else '',
                    'user_id': row[5],
                    'category_id': row[6],
                    'views': row[7],
                    'serving_size': row[8] if row[8] else '',
                    'preparation_time': row[9] if row[9] else '',
                    'cooking_time': row[10] if row[10] else '',
                    'tips': row[11] if row[11] else '',
                    'image_url': row[12] if row[12] else '',
                    'ingredients_sections': row[13] if row[13] else '',
                    'username': row[14] if row[14] else ''
                }
                recipes.append(recipe)
            
            return recipes
        except Exception as e:
            self.logger.error(f"Tarifler getirilirken hata: {str(e)}")
            raise Exception(f"Tarifler yüklenirken hata: {str(e)}")
            
    def search_recipes(self, query):
        """Tariflerde arama yapar"""
        try:
            if not self.connection:
                self.connect()
                
            cursor = self.connection.cursor()
            search_query = f"%{query}%"
            
            sql = """
                SELECT [id], [title], [ingredients], [instructions], [created_at],
                       [user_id], [category_id], [views], [serving_size],
                       [preparation_time], [cooking_time], [tips], [image_filename],
                       [ingredients_sections], [username]
                FROM dbo.Recipe 
                WHERE [title] LIKE ? OR [ingredients] LIKE ?
            """
            
            cursor.execute(sql, (search_query, search_query))
            recipes = []
            
            for row in cursor.fetchall():
                recipe = {
                    'id': row[0],
                    'title': row[1],
                    'ingredients': row[2] if row[2] else '',
                    'instructions': row[3] if row[3] else '',
                    'created_at': row[4].strftime('%Y-%m-%d') if row[4] else '',
                    'user_id': row[5],
                    'category_id': row[6],
                    'views': row[7],
                    'serving_size': row[8] if row[8] else '',
                    'preparation_time': row[9] if row[9] else '',
                    'cooking_time': row[10] if row[10] else '',
                    'tips': row[11] if row[11] else '',
                    'image_url': row[12] if row[12] else '',
                    'ingredients_sections': row[13] if row[13] else '',
                    'username': row[14] if row[14] else ''
                }
                recipes.append(recipe)
            
            return recipes
        except Exception as e:
            self.logger.error(f"Tarif araması yapılırken hata: {str(e)}")
            raise Exception(f"Tarif araması yapılırken hata: {str(e)}")

# Singleton instance
db_service = DatabaseService() 