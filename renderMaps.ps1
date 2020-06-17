# this is designed to run on keira's computer in particular. it shouldn't be *too* difficult to change, however.
# note that to export... i think all you'll need tbh is uhhh the Roadgeek 2005 fonts, plus probably changing a few env vars somewhere

Remove-Item "export" -Recurse -ErrorAction Ignore
mkdir "export" | out-null

python-qgis .\renderMaps.py
