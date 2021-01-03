# this is designed to run on keira's computer in particular. it shouldn't be *too* difficult to change, however.
# the big thing will be setting up pywikibot...
#
# run: python-qgis pwb/pwb.py pwb/generate_family_file
# then create a user-password.py: https://www.mediawiki.org/wiki/Manual:Pywikibot/BotPasswords
# run (to make sure it works): python-qgis pwb/pwb.py login


# this isnt 100% needed but...
python-qgis pwb/pwb.py login

# grab our revision tag
$tag = $(git describe --tags --dirty --always)


Get-ChildItem "export" -Filter *.png | 
Foreach-Object {
	echo $_.Name
	Switch ($_.Name) {
		'city.png' {$dest = 'Devilfish city.png'}
		'overview.png' {$dest = 'Devilfish overview.png'}
		'endbringers.png' {$dest = 'Endbringer map.png'}
		'prt-departments.png' {$dest = 'PRT departments.png'}
		default {return}
	}
	Measure-Command { python-qgis pwb/pwb.py upload -always -abortonwarn -ignorewarn:exists -filename:$dest $_.FullName "CLI upload from sylae/devilfish-map tag $tag" | Out-Default }
}
