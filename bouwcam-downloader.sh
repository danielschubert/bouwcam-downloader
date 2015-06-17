#!/bin/bash
# so sieht eine adresse zu einem bild aus:
# http://bouwcam.com/data/eponewmain/2015/06/2015-06-02_09-00.jpg

url="http://bouwcam.com/data/eponewmain"

# ... das Jahr
year=2015

# monate von bis (hier Mai bis Juni)
for month in `seq -w 05 06 `; do

	mkdir $month
	cd $month

    #tage von bis
    for day in `seq -w 01 31`; do

      #stunden
      for hour in `seq -w 06 22`; do
          #minuten
          for minute in `seq -w 0 10 50`; do
                   wget $url/$year/$month/$year-$month-$day\_$hour-$minute.jpg
          done
      done    

    done
    
    #zip machen ...
    echo "Mache jetzt ein Zip für den Monat $month"
	zip -T $month.zip *.jpg
	
	#aufräumen ..
	mv $month.zip ..
	
	cd ..
	rm -R $month
	
done


# generiere html datei mit Download Links:
echo "<ul>" > index.html
for i in `ls *.zip`
do
    echo "<li><a href=\"$i\">$i</a></li>" >> index.html
done
echo "</ul>" >> index.html
