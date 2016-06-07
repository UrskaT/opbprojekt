#parse za html
import csv
from bs4 import BeautifulSoup
import ciscenje
###zapisi v vec razlicnih fileov ID more bit model
def dodaj(file):
	html_file = BeautifulSoup(open(file),"html.parser")
	seznam_modelov = ciscenje.vsi_modeli(html_file)
	za_zapis = []
	for i in seznam_modelov:
		za_zapis.append(ciscenje.ciscenje(i,html_file))

	ciscenje.v_csv('output.csv', za_zapis) 