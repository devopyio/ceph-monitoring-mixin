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
              component: 'ceph-osd',
              grafana_url: '%(grafanaOSDDashboardURL)s' % $._config,
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
              component: 'ceph-osd',
              grafana_url: '%(grafanaOSDDashboardURL)s' % $._config,
            },
          },
        ],
      },
    ],
  },
}
