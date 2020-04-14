{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-pg',
        rules: [
          {
            alert: 'CephPGAreNotActive',
            expr: |||
              ceph_pg_total{%(cephExporterSelector)s} - ceph_pg_active{%(cephExporterSelector)s} != 0
            ||| % $._config,
            'for': '5m',
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
              ceph_pg_total{%(cephExporterSelector)s} - ceph_pg_clean{%(cephExporterSelector)s} != 0
            ||| % $._config,
            'for': '30m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              description: 'Placement groups contain objects that are not replicated the desired number of times. They should be recovering.',
            },
          },
        ],
      },
    ],
  },
}
