{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'systemd',
        rules: [
          {
            alert: 'CephSystemdUnitIsNotActive',
            expr: |||
              node_systemd_unit_state{%(cephSystemdUnitSelector)s, state="active"} != 1
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              description: 'Systemd unit {{$labels.name}} is not active.',
              grafana_url: '%(grafanaClusterDashboardURL)s' % $._config,
            },
          },
        ],
      },
    ],
  },
}
