local utils = import '../lib/utils.libsonnet';

{
  prometheusAlerts+::
    local addGrafanaDashboardURL(rule) = rule {
      [if 'alert' in rule && (rule.alert[0:7] == 'CephOSD' || rule.alert[0:6] == 'CephPG' || rule.alert[0:8] == 'CephNode') then 'annotations']+: {
        grafana_url: $._config.grafanaOSDDashboardURL,
      },
      [if 'alert' in rule && (rule.alert[0:7] == 'CephMgr' || rule.alert[0:8] == 'CephData' || rule.alert[0:11] == 'CephCluster') then 'annotations']+: {
        grafana_url: $._config.grafanaMgrDashboardURL,
      },
      [if 'alert' in rule && (rule.alert[0:7] == 'CephMds') then 'annotations']+: {
        grafana_url: $._config.grafanaMdsDashboardURL,
      },
      [if 'alert' in rule && (rule.alert[0:7] == 'CephMon') then 'annotations']+: {
        grafana_url: $._config.grafanaMonDashboardURL,
      },
    };
    utils.mapRuleGroups(addGrafanaDashboardURL),
}
