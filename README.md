# osrm-terraform

Deploy OSRM to AWS EC2 with Terraform.

Check out [evgeniyarbatov/on-demand-ec2](https://github.com/evgeniyarbatov/on-demand-ec2) to see how to setup AWS GW for OSRM.

# OSM Map

You need to add your own OSM map in `osrm/osm/hanoi.osm.pbf`.

Note that size of the map will affect the amount of memory required to run OSRM. If you know the bounding box of the region you need, use `osmconvert` to create an extract:

```
osmconvert \
~/osm/vietnam-latest.osm.pbf \
-b=105.7230968755703,20.94747599582269,105.88684857934376,21.102540254240452 \
-o=osm/hanoi.osm.pbf
```

## Terraform

```
tf init
tf apply -auto-approve
tf destroy -auto-approve
```

## Validate

Validate OSRM is working as expected by using Jupyter Notebook in `notebooks\Query EC2 OSRM.ipynb`
