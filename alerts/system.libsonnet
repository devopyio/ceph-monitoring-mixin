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
            },
          },
        ],
      },
    ],
  },
}
