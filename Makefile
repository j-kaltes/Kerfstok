

manifest.xml: manifest.xml.in
	cpp -P -E manifest.xml.in > manifest.xml

