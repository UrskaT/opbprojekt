# module za ciscenje podatkov
import csv

def ciscenje(id_s, html_file):
	info = html_file.find_all(id=id_s)	 #poiscemo podatke za dolocen avto
	model = info[0].h3.span.get_text('.')
	general = info[0].find_all(title="General Specs") #zberemo posamezne podatke za general, performance, transmission
	performance = info[0].find_all(title="Performance Specs")
	transmission = info[0].find_all(title="Transmission Specs")
	consumption = info[0].find_all(title="Fuel Consumption Specs")
	dimension = info[0].find_all(title="Dimensions Specs")
	weight = info[0].find_all(title="Weight Specs") ###potrebno dodati dimension specs, weight specs,
	#jih uredimo da dobimo string 
	seznam_g = general[0].get_text(';', strip=True)
	seznam_p = performance[0].get_text(';', strip=True)
	seznam_t = transmission[0].get_text(';', strip=True)
	seznam_c = consumption[0].get_text(';', strip=True)
	seznam_d = dimension[0].get_text(';', strip=True)
	seznam_w = weight[0].get_text(';', strip=True)
	#zdruzimo in naredimo seznam
	s = "%s;%s;%s;%s;%s;%s;%s" % (model,seznam_g,seznam_p,seznam_t,seznam_c,seznam_d,seznam_w)
	s = s.split(";")
	#seznam vseh imen 
	imena = info[0].find_all('dt')
	sez_imen = []
	#imena spravimo v seznam, da jih lahko kasneje uporabimo za primerjavo
	for i in range(0, len(imena)):
		sez_imen.append(imena[i].get_text("", strip=True))

	for i in s:
		if 'in' in i.split(' '): sez_imen.append(i)
		elif 'mpg' in i.split(' '): sez_imen.append(i)
		elif 'mph' in i.split(' '): sez_imen.append(i)
		elif 'HP' in i.split(' '): sez_imen.append(i)
		elif 'BHP' in i.split(' '): sez_imen.append(i)
		elif 'lbs' in i.split(' '): sez_imen.append(i)
		elif 'lb-ft' in i.split(' '): sez_imen.append(i)
		elif 'OR' in i.split(' '): sez_imen.append(i)

	#iz seznama podatkov izlocimo ime, ostanejo samo vrednosti, ki jih vrnemo kot seznam
	for i in range(0, len(sez_imen)):
		if sez_imen[i] in s: s.remove(sez_imen[i])

	return s


#vse tipe dolocenega modela zapisemo v seznam
def vsi_modeli(html_file):
	s = []
	for tag in html_file.find_all(class_="engine-block"):
		s.append(tag.get('id'))
	return s



#zapis podatkov v csv, ce zelim naredit now file 'w', ce zelim dodati vrstico'a'
def zapis(file, seznam):
	with open(file, 'a', newline='') as f: 
		writer = csv.writer(f)
		writer.writerow(seznam)

def v_csv(file, seznam):
	for i in seznam:
		zapis(file,i)
