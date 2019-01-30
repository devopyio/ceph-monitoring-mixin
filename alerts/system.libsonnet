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
            alert: 'CephOSDDown',
            expr: |||
              sum(ceph_osd_up{%(cephMgrSelector)s}) != %(cephOsdCount)d
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph OSD is down.',
            },
          },
          {
            alert: 'CephOSDNotIn',
            expr: |||
              sum(ceph_osd_in{%(cephMgrSelector)s}) != %(cephOsdCount)d
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph OSD is not in the cluster.',
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
          {
            alert: 'CephMonQuorumStatus',
            expr: |||
              sum(ceph_mon_quorum_status{%(cephMgrSelector)s}) != %(cephMonCount)d
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Ceph Healh status is ERR.',
            },
          },

        ],
      },
    ],
  },
}
