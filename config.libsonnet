local ceph = import 'github.com/ceph/ceph-mixins/mixin.libsonnet';
local utils = import 'lib/utils.libsonnet';
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
+ {
  prometheusAlerts+::
    local fixDuplicateAlertName(rule) = rule {
      local expr = if 'alert' in rule && rule.alert == 'CephClusterNearFull' then 'sum(ceph_osd_stat_bytes_used) / sum(ceph_osd_stat_bytes) > 0.90' else rule.expr,

      expr: expr,
    };
    utils.mapRuleGroups(fixDuplicateAlertName),
}
+ {
  prometheusAlerts+::
    local fixDuplicateAlertName(rule) = rule {
      local expr = if 'alert' in rule && rule.alert == 'CephOSDNearFull' then '(ceph_osd_metadata * on (ceph_daemon) group_left() (ceph_osd_stat_bytes_used / ceph_osd_stat_bytes)) >= 0.85' else rule.expr,

      expr: expr,
    };
    utils.mapRuleGroups(fixDuplicateAlertName),
}
