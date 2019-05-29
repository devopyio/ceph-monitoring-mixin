local utils = import '../lib/utils.libsonnet';

{
  prometheusAlerts+::
    local removeSeverity(rule) = rule {
      [if 'alert' in rule then 'annotations']+: {
        severity_level:: '',
      },
    };
    utils.mapRuleGroups(removeSeverity),
}
