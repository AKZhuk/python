#!/usrM/bin/env python 3import pdbimport urllib.requestfrom bs4 import BeautifulSoupdef get_html(url):	response = urllib.request.urlopen(url)	return response.read()def parse(html):		project = []		soup = BeautifulSoup(html,"html5lib")		table = soup.find('td', class_='b-currency-table-list')		for row in table.find_all('tr', class_='tr-main'):			 cols = row.find_all('b')			 del(cols[1])			 # pdb.set_trace()			 # print(cols[1].text)			 project.append({				'покупка' : cols[1].text,			 	'продажа' : cols[2].text,			 	'валюта' : cols[0].text			 	})			 		for item in project:			 	print(item)def main():	parse(get_html('http://kurs.onliner.by/'))if __name__=='__main__':	main()