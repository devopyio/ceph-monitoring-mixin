# Ceph monitoring mixin

> NOTE: This project is *alpha* stage. Flags, configuration, behaviour and design may change significantly in following releases.

A set of Grafana dashboards and Prometheus alerts for Ceph.

## How to use

This mixin is designed to be vendored into the repo with your infrastructure config.
To do this, use [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler):

Generate the config files and deploy them yourself

## Generate config files

You can manually generate the alerts files, but first you must install some tools:

```
$ make setup
```

Mac: 
```
$ brew install jsonnet
```

Linux:
```
sudo snap install jsonnet
```

Then, grab the mixin and its dependencies:

```
$ git clone https://github.com/devopyio/ceph-monitoring-mixin
$ cd ceph-monitoring-mixin
$ jb install
```

Finally, build the mixin:

```
$ make prometheus_alerts.yaml
```

The `prometheus_alerts.yaml` file then need to passed to your Prometheus server, 
The exact details will depending on how you deploy your Prometheus.

