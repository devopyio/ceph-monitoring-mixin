local utils = import '../lib/utils.libsonnet';

{
  prometheusAlerts+::
    local removeStorageType(rule) = rule {
      [if 'alert' in rule then 'annotations']+: {
        storage_type:: '',
      },
    };
    utils.mapRuleGroups(removeStorageType),
}
