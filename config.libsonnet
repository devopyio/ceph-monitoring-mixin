{
  _config+:: {
    // Selectors are inserted between {} in Prometheus queries.
    cephMgrSelector: 'job="ceph"',

    cephSystemdUnitSelector: 'name=~"ceph.*"',

    // Number of Ceph Managers which are reporting metrics
    cephMgrCount: 3,

    // Number of Ceph Monitors
    cephMonCount: 3,

    // Number of Ceph OSDs
    cephOsdCount: 3,

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
  },
}
