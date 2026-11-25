// Sağ tık menüsünde "Aç" altına (2. sıra) tüm sıkıştırılmış/arşiv uzantıları için "Klasöre çıkart" öğesi ekler
item(
	type='file'
	mode='multiple'
	find='.zip|.rar|.7z|.tar|.gz|.gzip|.tgz|.tpz|.bz2|.bzip2|.tbz2|.tbz|.xz|.txz|.zst|.tzst|.lzma|.z|.taz|.zipx|.cab|.arj|.lzh|.lha|.iso|.img|.udf|.wim|.swm|.esd|.dmg|.xar|.cpio|.rpm|.deb|.jar|.xpi|.apk|.r00|.001'
	title='Klasöre çıkart'
	image=icon.extract_to
	pos=1
	cmd='C:\Program Files\7-Zip\7zG.exe'
	args='x @sel.path.quote -o"@(path.join(path.location(sel.path), path.file.title(sel.path)))"'
	invoke='multiple'
)
