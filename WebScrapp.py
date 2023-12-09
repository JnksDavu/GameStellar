import requests
from bs4 import BeautifulSoup
import pandas as pd
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore



cred = credentials.Certificate('gamestellar-4c31a-firebase-adminsdk-3w0xp-44393614a6.json')
firebase_admin.initialize_app(cred)

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36 OPR/102.0.0.0'
}



def Url_Noticias(noticias):
   conteudo = noticias.find('h3', string='Review: Sonic Superstars é uma estrela guia para os platformers')
   cont = conteudo.find('a')['href']
   return cont

def Img_news(noticias):
    conteudo = noticias.find('div', {'class':'thumb'})
    cont = conteudo.find('a')
    img = cont.find('img')
    return img.get('src')

def Titulo_News(noticias):
   tudo = noticias.find_all('div', {'class':'grid'})
   
   tabela = []

   for cont in tudo:
        descri = cont.find('div',{'class':'content'})
        tag = cont.find('a',{'class':'tag'})
        if descri is not None:
            desc = descri.find('h3')
            if desc is not None:
                link = desc.find('a')
                if link is not None:
                    img = cont.find('div', {'class':'thumb'})
                    if img is not None:
                        img_link = img.find('a')
                        if img_link is not None:
                            imagem = img_link.find('img')
                            if imagem is not None:
                                tabela.append({
                                    'URL': link['href'],
                                    'Titulo': link.text,
                                    'Img': imagem['src'],
                                    'Tag': tag.text
                                })

   return tabela

def extrair_texto_p(url):
    site = requests.get(url, headers=headers)
    soup = BeautifulSoup(site.content, 'html.parser')
    paragrafos = soup.find_all('div',{'class':'text-top'})
    textos = [p.text for p in paragrafos]
    return ' '.join(textos)

db = firestore.client()

for i in range(1, 4):
    url = f'https://flowgames.gg/categorias/games/page/{i}/'
    site_noticias = requests.get(url, headers= headers)
    noticias = BeautifulSoup(site_noticias.content, 'html.parser')

    titulo = Titulo_News(noticias)
    img = Img_news(noticias)

    colunas = pd.DataFrame(titulo)
    Tabela = colunas.to_dict(orient='records')

    for i, row in colunas.iterrows():
        data = row.to_dict()
        data['Texto'] = extrair_texto_p(data['URL'])  # Adicione esta linha
        colec_id = str(data['Tag'])
        
        # Verifique se o título já existe no Firestore
        docs = db.collection(colec_id).where('Titulo', '==', data['Titulo']).get()
        
        # Se não existir, adicione ao Firestore
        if not docs:
            db.collection(colec_id).add(data)
