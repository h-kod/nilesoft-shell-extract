// Sağ tık menüsünde "Aç" altına (2. sıra) "Klasöre çıkart" öğesi ekler
item(
	type='file'
	mode='multiple'
	find='.zip'
	title='Klasöre çıkart'
	image=icon.extract_to
	pos=1
	cmd='C:\Program Files\7-Zip\7zG.exe'
	args='x @sel.path.quote -o"@(path.join(path.location(sel.path), path.file.title(sel.path)))"'
	invoke='multiple'
)
