{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-system',
        rules: [
          {
            alert: 'CephHealthStatusErr',
            expr: |||
              ceph_health_status{%(cephMgrSelector)s} == 2 
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Ceph Healh status is ERR.',
              component: 'general',
              grafana_url: '%(grafanaClusterDashboardURL)s' % $._config,
            },
          },
          {
            alert: 'CephHealthStatusWarn',
            expr: |||
              ceph_health_status{%(cephMgrSelector)s} == 1
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph Healh status is WARN.',
              component: 'general',
              grafana_url: '%(grafanaClusterDashboardURL)s' % $._config,
            },
          },
          {
            alert: 'CephOSDVersionMismatch',
            expr: |||
              count(count(ceph_osd_metadata{%(cephMgrSelector)s}) by (ceph_version)) > 1
            ||| % $._config,
            'for': '1h',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'There are {{ $value }} different versions of Ceph OSD components running.',
              component: 'ceph-osd',
              grafana_url: '%(grafanaOSDDashboardURL)s' % $._config,
            },
          },
          {
            alert: 'CephMonVersionMismatch',
            expr: |||
              count(count(ceph_mon_metadata{%(cephMgrSelector)s}) by (ceph_version)) > 1
            ||| % $._config,
            'for': '1h',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'There are {{ $value }} different versions of Ceph OSD components running.',
              component: 'ceph-monitor',
              grafana_url: '%(grafanaMonDashboardURL)s' % $._config,
            },
          },
        ],
      },
    ],
  },
}
