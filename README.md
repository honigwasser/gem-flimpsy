# Flimpsy

This project contains a gem that downloads ten images from flickr and builds a college grid on an empty canvas.

## Starting the app

  Either use it as a **gem** or clone the github repository `honigwasser/gem-flimpsy`:

	docker-compose build
	docker-compose run app bash -l
	bundle console

## Public methods

	create/1

  The only argument is a hash with two required keys: `to_file` and `from_keywords`.
  Keywords should be given as a list of comma separated strings. Filename must be a valid PNG filepath.
  Folders won't be created.

## Example commands

	Flimpsy.create(from_keywords: "miyajima, paris, berlin, helsinki, amsterdam", to_file: "./test.png")

## Please note

  - Searching via the flickr API takes some time.
  - Since "top-rated" is rather unspecified, I'll stick to flickrs own most relevant ranking
  - There is a small chance that less than ten images are retrieved. There is still room for improvement.
  - Images are cropped to 400px * 200px
  - Cropped images will be cached in a temporary folder.
  - Original images will be deleted directly after use to save space.
  - Images are placed on a 800px * 800px canvas
  - After each run old cropped images will be removed from the cache.
  - Things that need some brain power: overall performance, file handling, exception handling
