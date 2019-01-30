{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-pg',
        rules: [
          {
            alert: 'CephPGAreNotActive',
            expr: |||
              ceph_pg_active{%(cephMgrSelector)s} != ceph_pg_total{%(cephMgrSelector)s}
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Placement Groups are not active.',
            },
          },
          {
            alert: 'CephPGAreUnclean',
            expr: |||
              ceph_pg_clean{%(cephMgrSelector)s} != ceph_pg_total{%(cephMgrSelector)s}
            ||| % $._config,
            'for': '15m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Placement Groups are not clean.',
            },
          },
        ],
      },
    ],
  },
}
