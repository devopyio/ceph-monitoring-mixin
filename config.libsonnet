local ceph = import 'github.com/ceph/ceph-mixins/mixin.libsonnet';

ceph {
  _config+:: {
    // Selectors are inserted between {} in Prometheus queries.
    cephExporterSelector: 'job="ceph"',

    cephSystemdUnitSelector: 'name=~"ceph.*"',

    // Number of Ceph Managers which are reporting metrics
    cephMgrCount: 3,

    // Number of Ceph Monitors
    cephMonCount: 3,

    // Number of Ceph OSDs
    cephOsdCount: 3,

    // Number of Ceph Mds
    cephMdsCount: 1,

    // Link To Ceph Dashboard, this will add dashboard_url to every alert.
    // More info: http://docs.ceph.com/docs/master/mgr/dashboard/
    dashboardURL: '',

    // Grafana url for Ceph-Cluster dashboard
    grafanaClusterDashboardURL: '',

    // Grafana url for OSD overview dashboard
    grafanaOSDDashboardURL: '',

    // Grafana url for Ceph-Cluster dashboard
    grafanaMonDashboardURL: '',

    // Grafana url for Ceph-Cluster dashboard
    grafanaMgrDashboardURL: '',

    // Grafana url for Ceph-Cluster dashboard
    grafanaMdsDashboardURL: '',

  },
}
