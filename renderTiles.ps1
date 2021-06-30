# this is designed to run on keira's computer in particular. it shouldn't be *too* difficult to change, however.
# note that to export... i think all you'll need tbh is uhhh the Roadgeek 2005 fonts, plus probably changing a few env vars somewhere

Remove-Item "export-tiles" -Recurse -ErrorAction Ignore
mkdir "export-tiles" | out-null

$env:devilfishGitRev = $(git describe --tags --dirty --always)

Measure-Command { python-qgis .\renderTiles.py devilfish.qgs | Out-Default }

php renderTilesHTMLFixer.php

Measure-Command { 
	Get-ChildItem "export-tiles" -recurse -Filter *.png | Foreach-Object -Parallel {
		optipng $_.FullName
	} -ThrottleLimit 8
}

Measure-Command {
	scp export-tiles/map.cdn.html syl.ae:~/public_html/wormrpmap.php
	aws s3 sync export-tiles/ s3://cdn.syl.ae/wormrp/map/ --acl public-read
}
