{
  _config+:: {
    // Selectors are inserted between {} in Prometheus queries.
    cephMgrSelector: 'job="ceph"',

    // Number of Ceph Managers which are reporting metrics
    cephMgrCount: 3,

    // Number of Ceph Monitors
    cephMonCount: 3,

    // Number of Ceph OSDs
    cephOsdCount: 3,
  },
}
