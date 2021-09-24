# this is designed to run on keira's computer in particular. it shouldn't be *too* difficult to change, however.
# note that to export... i think all you'll need tbh is uhhh the Roadgeek 2014 fonts, plus probably changing a few env vars somewhere

$python = "C:\Program Files\QGIS 3.20.3\bin\python-qgis"

Remove-Item "export" -Recurse -ErrorAction Ignore
mkdir "export" | out-null

$env:devilfishGitRev = $(git describe --tags --dirty --always)

Get-ChildItem "." -Filter *.qgs | 
Foreach-Object {
	if ($_.FullName -notmatch '\~$')  {
		echo $_.FullName
		Measure-Command { & $python .\renderMaps.py $_.FullName | Out-Default }
	}
}


Measure-Command { 
	Get-ChildItem "export" -Filter *.png | 	Foreach-Object -Parallel {
		echo $_.FullName
		optipng $_.FullName
	} -ThrottleLimit 8
}