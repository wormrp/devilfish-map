from qgis.core import *
from osgeo import gdal
import os
import sys

gdal.PushErrorHandler('CPLQuietErrorHandler')

qgs = QgsApplication([], False)
qgs.initQgis()
project = QgsProject.instance()
project.read(sys.argv[1])

layouts = project.layoutManager().layouts()
settings = QgsLayoutExporter.ImageExportSettings()
settings.dpi = 300
for layout in layouts:
    QgsLayoutExporter(layout).exportToImage(os.path.join(os.getcwd(), "export", layout.name() + ".png"), settings)

qgs.exitQgis()
