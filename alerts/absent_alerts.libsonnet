{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-absent',
        rules: [
          {
            alert: 'CephMgrIsAbsent',
            expr: |||
              absent(up{%(cephMgrSelector)s} == 1)
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Ceph Manager has disappeared from Prometheus target discovery.',
            },
          },
        ],
      },
      {
        name: 'ceph-down',
        rules: [
          {
            alert: 'CephMgrIsMissingReplicas',
            expr: |||
              sum(up{%(cephMgrSelector)s}) != %(cephMgrCount)d
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph Manager is missing replicas.',
            },
          },
        ],
      },
    ],
  },
}
