# Galaxy Helm Microservices Charts
Umbrella chart to install galaxy.  

## Requirements
Make sure your `kubectl` is configured to talk to some K8S cluster, and your `helm` client is initialized.

## Installation
Since the Umbrella chart installs its' subcharts, which in turn depend on the Common chart, a recursive dependency update strategy was required. A simple `helm dep up` command wouldn't do the job here. Hence, run the following script:
```
./helm-dep-up-umbrella.sh umbrella-chart
```

Next, simply install the Umbrella chart:
```
helm install helm-chart
```

### Configuration
There are several ways to override specific subcharts values.  
However, each subchart should contain it's own config inside the chart path (i.e. the `.env` file).
