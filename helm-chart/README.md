# Galaxy Helm Microservices Charts
Umbrella chart to install galaxy.  

## Requirements
Make sure your `kubectl` is configured to talk to some K8S cluster, and your `helm` client is initialized.

## Installation
Since the Umbrella chart installs its' subcharts, which in turn depend on the Common chart, a recursive dependency update strategy was required. A simple `helm dep up` command wouldn't do the job here. Hence, run the following script:
```
./helm-dep-up-umbrella.sh galaxy
```
Next to publish the package, and install from your repo.
1. **helm package
2. **[push package to repo](https://c6supper.github.com/helm-repo/README.md)
3. **make sure your k8s have the "galaxy-dev" namespace.
4. **helm install galaxy

### Configuration
There are several ways to override specific subcharts values.
```
1.Set the value in Umbrella chart values.yaml
2.Override specific sub chart values using --set <subchart_name>.image=v2
```
However, each subchart should contain it's own config inside the chart path (i.e. the `.env` file).
