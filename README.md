# osrm-terraform

Host OSRM with AWS EC2 with Terraform.

# OSM Map

You need to add your own OSM map in `osrm/osm/hanoi.osm.pbf`.

Note that size of the map will affect the amount of memory required to run OSRM.

If you know the bounding box of the region you need, use this to create an extract:

```
osmconvert \
~/osm/vietnam-latest.osm.pbf \
-b=105.7157,20.9516,105.8912,21.0558 \
-o=osm/hanoi.osm.pbf
```

## Deploy

```
tf init
tf apply -auto-approve
```