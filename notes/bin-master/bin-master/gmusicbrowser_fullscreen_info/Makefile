# Simple Makefile to experiment and develop
# my "Full screen mode for GMusicBrowser" program

main:	open_chromium run

run:
	FLASK_APP=start_ui.py flask run --host=0.0.0.0 --port=9999

debug:
	export FLASK_DEBUG=1
	FLASK_APP=start_ui.py flask run --host=0.0.0.0 --port=9999

open_firefox:
	firefox http://0.0.0.0:9999/ &

open_chromium:
	chromium-browser http://0.0.0.0:9999/ &

test_start:
	./update_ui.py start "Titre de la chanson" "Artiste de la chanson" "Album de la chanson" "Année : 2018" "Disque 1" "1" "test.mp3" "test.jpg"

test_stop:
	./update_ui.py stop "Titre de la chanson" "Artiste de la chanson" "Album de la chanson" "Année : 2018" "Disque 1" "1" "test.mp3" "test.jpg"

clean:
	-rm -vfr __pycache__/ *.pyc
