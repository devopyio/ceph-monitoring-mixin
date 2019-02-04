{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-osd',
        rules: [
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
              (ceph_osd_stat_bytes_used{%(cephMgrSelector)s} / ceph_osd_stat_bytes{%(cephMgrSelector)s}) * 100 > 85
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: '{{$labels.ceph_daemon}} Ceph OSD used more than 85 % of disk space.',
            },
          },
        ],
      },
    ],
  },
}
