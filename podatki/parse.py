import urllib.request
from xml.etree.ElementTree import parse

def parser(url):
	u = urllib.request.urlopen(url)
	data = u.read()
	f = open('stran.html', 'wb')
	f.write(data)
	f.close
	doc = parse('stran.html')



