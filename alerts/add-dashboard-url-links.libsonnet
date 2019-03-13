local utils = import '../lib/utils.libsonnet';

{
  prometheusAlerts+::
    local addDashboardURL(rule) = rule {
      [if $._config.dashboardURL != '' && 'alert' in rule then 'annotations']+: {
        dashboard_url: $._config.dashboardURL,
      },
    };
    utils.mapRuleGroups(addDashboardURL),
}
