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
              message: 'Systemd unit {{$labels.name}} is not active.',
              component: 'general',
              grafana_url: '%(grafanaClusterDashboardURL)s' % $._config,
            },
          },
        ],
      },
    ],
  },
}
