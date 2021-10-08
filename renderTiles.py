from qgis.core import *
from qgis import processing
from osgeo import gdal
import os
import sys
from PyQt5.QtGui import QColor

gdal.PushErrorHandler('CPLQuietErrorHandler')
qgs = QgsApplication([], False)
qgs.initQgis()

sys.path.append('C:\\Program Files\\QGIS 3.20.3\\apps\\qgis\\python\\plugins')

import processing
from processing.core.Processing import Processing
Processing.initialize()

project = QgsProject.instance()
project.read(sys.argv[1])

processing.run("qgis:tilesxyzdirectory", {'EXTENT':'-91.145624973,-89.211017226,47.356527267,48.282137008 [EPSG:4326]','ZOOM_MIN':11,'ZOOM_MAX':15,'DPI':96,'BACKGROUND_COLOR':QColor(0, 0, 0, 0),'TILE_FORMAT':0,'QUALITY':75,'METATILESIZE':4,'TILE_WIDTH':256,'TILE_HEIGHT':256,'TMS_CONVENTION':False,'OUTPUT_DIRECTORY':'export-tiles','OUTPUT_HTML':'export-tiles/map.tpl.html'})

qgs.exitQgis()