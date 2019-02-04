{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-pg',
        rules: [
          {
            alert: 'CephPGAreNotActive',
            expr: |||
              ceph_pg_total{%(cephMgrSelector)s} - ceph_pg_active{%(cephMgrSelector)s} != 0
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Some Placement Groups are not active.',
            },
          },
          {
            alert: 'CephPGAreUnclean',
            expr: |||
              ceph_pg_total{%(cephMgrSelector)s} - ceph_pg_clean{%(cephMgrSelector)s} != 0
            ||| % $._config,
            'for': '30m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Placement groups contain objects that are not replicated the desired number of times. They should be recovering.',
            },
          },
          {
            alert: 'CephOSDDown',
            expr: |||
              ceph_osd_up{%(cephMgrSelector)s} != 1
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: '{{$labels.ceph_daemon}} Ceph OSD is down.',
            },
          },
          {
            alert: 'CephOSDNotIn',
            expr: |||
              ceph_osd_in{%(cephMgrSelector)s} != 1
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: '{{$labels.ceph_daemon}} Ceph OSD is out of the cluster, CRUSH will not assign placement groups to the OSD.',
            },
          },
          {
            alert: 'CephOSDLowSpace',
            expr: |||
              (ceph_osd_stat_bytes_used{%(cephMgrSelector)s} / ceph_osd_stat_bytes{%(cephMgrSelector)s}) * 100 > 90
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: '{{$labels.ceph_daemon}} Ceph OSD used more than 90 % of disk space',
            },
          },

        ],
      },
    ],
  },
}
