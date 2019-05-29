local utils = import '../lib/utils.libsonnet';

{
  prometheusAlerts+::
    local removeMessage(rule) = rule {
      [if 'alert' in rule then 'annotations']+: {
        message:: '',
      },
    };
    utils.mapRuleGroups(removeMessage),
}
