{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ceph-mon',
        rules: [
          {
            alert: 'CephMonInsufficientMembers',
            expr: |||
              sum(ceph_mon_quorum_status{%(cephMgrSelector)s} == bool 1) by (job) < ((count(ceph_mon_quorum_status{%(cephMgrSelector)s}) by (job) + 1) / 2)
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph Monitor "{{ $labels.job }}": insufficient members ({{ $value }}).',
            },
          },
          {
            alert: 'CephMonNoQuorum',
            expr: |||
              ceph_mon_quorum_status{%(cephMgrSelector)s} == 0
            ||| % $._config,
            'for': '1m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Ceph Monitor "{{ $labels.job }}": member {{ $labels.instance }} has no quorum.',
            },
          },
          {
            alert: 'CephMonHighNumberOfLeaderChanges',
            expr: |||
              rate(ceph_mon_num_elections{%(cephMgrSelector)s}[15m]) > 3
            ||| % $._config,
            'for': '15m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              message: 'Ceph Monitor "{{ $labels.job }}": instance {{ $labels.instance }} has seen {{ $value }} leader changes within the last 30 minutes.',
            },
          },
          {
            alert: 'CephMonQuorumStatus',
            expr: |||
              ceph_mon_quorum_status{%(cephMgrSelector)s} != 1
            ||| % $._config,
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'Ceph Monitor reporting bad quorum status.',
            },
          },
        ],
      },
    ],
  },
}
