# Ceph Alert Runbooks

As Rob Ewaschuk [puts it](https://docs.google.com/document/d/199PqyG3UsyXlwieHaqbGiWVa8eMWi8zzAn0YfcApr8Q/edit#):
> Playbooks (or runbooks) are an important part of an alerting system; it's best to have an entry for each alert or family of alerts that catch a symptom, which can further explain what the alert means and how it might be addressed.

It is a recommended practice that you add an annotation of "runbook" to every prometheus alert with a link to a clear description of it's meaning and suggested remediation or mitigation. While some problems will require private and custom solutions, most common problems have common solutions. In practice, you'll want to automate many of the procedures (rather than leaving them in a wiki), but even a self-correcting problem should provide an explanation as to what happened and why to observers.

Matthew Skelton & Rob Thatcher have an excellent [run book template](https://github.com/SkeltonThatcher/run-book-template). This template will help teams to fully consider most aspects of reliably operating most interesting software systems, if only to confirm that "this section definitely does not apply here" - a valuable realization.

This page collects this repositories alerts and begins the process of describing what they mean and how it might be addressed. Links from alerts to this page are added [automatically](https://github.com/devopyio/ceph-monitoring-mixin/blob/master/alerts/add-runbook-links.libsonnet).


### Group Name: "ceph-osd"
##### Alert Name: "CephOSDDown"
+ *Message*: `Ceph OSD is down.`
+ *Severity*: warning

URL:

http://docs.ceph.com/docs/mimic/rados/troubleshooting/troubleshooting-osd/#osd-not-running

##### Alert Name: "CephOSDNotIn"
+ *Message*: `Ceph OSD is down.`
+ *Severity*: warning

URL:

http://docs.ceph.com/docs/mimic/rados/operations/monitoring-osd-pg/#monitoring-osds
http://docs.ceph.com/docs/mimic/rados/troubleshooting/troubleshooting-osd/#osd-not-running

##### Alert Name: "CephOSDLowSpace"
+ *Message*: `Ceph OSD used more than 85 % of disk space.`
+ *Severity*: warning

URL:

http://docs.ceph.com/docs/mimic/rados/configuration/mon-config-ref/#storage-capacity
http://docs.ceph.com/docs/mimic/rados/operations/add-or-rm-osds/

### Group Name: "ceph-pg"
##### Alert Name: "CephPGAreNotActive"
+ *Message*: `Some Placement Groups are not active.`
+ *Severity*: critical

```
ceph pg dump_stuck inactive
```

URL:

http://docs.ceph.com/docs/mimic/rados/troubleshooting/troubleshooting-pg/#stuck-placement-groups

##### Alert Name: "CephPGAreUnclean"
+ *Message*: `Placement groups contain objects that are not replicated the desired number of times. They should be recovering.`
+ *Severity*: warning

```
ceph pg dump_stuck unclean
```

URL:

http://docs.ceph.com/docs/mimic/rados/troubleshooting/troubleshooting-pg/#stuck-placement-groups

## Other Ceph Runbooks and troubleshooting

+ [Troubleshooting PGS](http://docs.ceph.com/docs/mimic/rados/troubleshooting/troubleshooting-pg/#troubleshooting-pg-errors)
+ [Health checks](http://docs.ceph.com/docs/mimic/rados/operations/health-checks/)
