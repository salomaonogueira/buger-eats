from pymongo import MongoClient
import os
from dotenv import load_dotenv
from bson.objectid import ObjectId

# Carregar variáveis de ambiente do arquivo .env
load_dotenv(os.path.join(os.path.dirname(__file__), '../../api/.env'))

# Conectar ao banco de dados MongoDB
mongo_uri = os.getenv('MONGO_URI')
mongo_db_name = os.getenv('MONGO_DB_NAME', 'bugereats')  # Defina o nome do banco de dados padrão
mongo_collection_name = os.getenv('MONGO_COLLECTION_NAME', 'partners')  # Defina o nome da coleção padrão

if not mongo_uri:
    raise ValueError("Variável de ambiente MONGO_URI deve estar definida")

client = MongoClient(mongo_uri)
db = client[mongo_db_name]
collection = db[mongo_collection_name]

def factory_new_partner():
    partner = {
        'name': 'Pizzas Papito',
        'email': 'contato@papito.com.br',
        'whatsapp': '11999999999',
        'business': 'Restaurante'
    }
    return partner

def factory_duplicate_name():
    partner = {
        'name': 'Adega do Salomão',
        'email': 'contato@salomao.com.br',
        'whatsapp': '92999999999',
        'business': 'Conveniência'
    }
    return partner

def delete_partner_by_name(name):
    """Deleta um parceiro pelo nome."""
    print(f"Tentando deletar parceiro com o nome: {name}")
    result = collection.delete_many({"name": name})
    print(f"Deletados {result.deleted_count} registros.")
    return result.deleted_count

def find_partner_by_name(name):
    """Busca um parceiro pelo nome no banco de dados"""
    print(f"Buscando parceiro com o nome: {name}")
    result = collection.find_one({"name": name})
    print(f"Resultado da busca: {result}")
    return result if result else None

def find_partner_by_id(partner_id):
    """Busca um parceiro pelo ID no banco de dados"""
    print(f"Buscando parceiro com o ID: {partner_id}")
    result = collection.find_one({"_id": ObjectId(partner_id)})
    print(f"Resultado da busca: {result}")
    return result if result else None

def delete_partner_by_id(partner_id):
    """Deleta um parceiro pelo ID."""
    print(f"Tentando deletar parceiro com o ID: {partner_id}")
    result = collection.delete_one({"_id": ObjectId(partner_id)})
    print(f"Deletados {result.deleted_count} registros.")
    return result.deleted_count

def partner_exists(name):
    """Verifica se um parceiro existe no banco de dados"""
    print(f"Verificando se parceiro existe com o nome: {name}")
    result = collection.find_one({"name": name})
    print(f"Parceiro existe: {result is not None}")
    return result is not None

def factory_partner_list():
    """Retorna uma lista de parceiros fictícios"""
    p_list = [
        {'name': 'Mercearia da Mary Jane', 'email': 'contato@mmj.com', 'whatsapp': '11999991001', 'business': 'Conveniência'},
        {'name': 'Mercadinho Sao Francisco', 'email': 'contato@msf.com.br', 'whatsapp': '11999991002', 'business': 'Supermercado'},
        {'name': 'Bom de prato', 'email': 'contato@bomdeprato.com.br', 'whatsapp': '11999991003', 'business': 'Restaurante'}
    ]
    return p_list

def factory_404_list():
    partner = {
        'name': 'Frangão',
        'email': 'contato@frangao.com',
        'whatsapp': '11999991004',
        'business': 'Restaurante'
    }
    return partner

def factory_enable_partner():
    partner = {
        'name': 'Doceria do Salomão',
        'email': 'contato@salomao.com',
        'whatsapp': '11999991005',
        'business': 'Conveniência'
    }
    return partner

def factory_disable_partner():
    partner = {
        'name': 'Assado do Salomão',
        'email': 'contato@assado.com',
        'whatsapp': '11999991006',
        'business': 'Conveniência'
    }
    return partner

def factory_remove_partner():
    partner = {
        'name': 'Supermecado do Salomão',
        'email': 'contato@salomao.com',
        'whatsapp': '11999991007',
        'business': 'Supermercado'
    }
    return partner

def factory_404_partner():
    partner = {
        'name': 'Churrascaria do Salomão',
        'email': 'contato@frangao.com',
        'whatsapp': '11999991008',
        'business': 'Restaurante'
    }
    return partner