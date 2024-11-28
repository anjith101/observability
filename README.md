# Monitoring
This project aims to build a comprehensive observability solution for applications deployed on AWS Elastic Kubernetes Service (EKS). The solution leverages Prometheus, Grafana, and Alertmanager for metrics collection, visualization, and alerting. It also integrates Elasticsearch, Fluent Bit, and Kibana (EFK) for centralized log aggregation and analysis, along with Jaeger for distributed tracing.

The observability stack is deployed using Terraform for infrastructure automation, ensuring scalability, maintainability, and repeatability. The Kubernetes cluster is managed by AWS EKS Managed Nodegroups, simplifying the lifecycle management of worker nodes.

This project provides a unified platform for monitoring application performance, debugging issues, and gaining insights into system behaviour.

## Architecture Explanation
The observability solution consists of three core components, each addressing a different aspect of system monitoring:

### Metrics Monitoring (Prometheus, Grafana, and Alertmanager)
- Prometheus is deployed as a metrics scraper, pulling metrics from Kubernetes workloads, nodes, and system components via the Prometheus Node Exporter and other exporters.
- Grafana visualizes the collected metrics, providing rich dashboards for real-time monitoring and historical analysis.
- Alertmanager integrates with Prometheus to handle alert notifications, ensuring that anomalies and threshold breaches are promptly reported via configured channels.

### Log Aggregation and Analysis (Elasticsearch, Fluent Bit, and Kibana)
- Fluent Bit acts as the log shipper, collecting logs from Kubernetes Pods and nodes. It processes and forwards these logs to Elasticsearch.
- Elasticsearch serves as the central data store for logs, enabling powerful querying and filtering.
- Kibana provides a user-friendly interface for visualizing and exploring logs, allowing teams to diagnose and debug issues efficiently.

###  Distributed Tracing (Elasticsearch, Fluent Bit, and Jaeger)
- Jaeger collects and visualizes distributed traces, enabling the analysis of application performance and the identification of bottlenecks.
- Fluent Bit forwards trace data to Elasticsearch, where it can be queried using both Jaeger and Kibana for deeper insights.

### Prerequisites
- Download and Install AWS Cli - Please Refer [this]("https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html") link.
- Setup and configure AWS CLI using the `aws configure` command.
- Install Terraform using the steps mentioned [here]("https://developer.hashicorp.com/terraform/install").
- Install and configure kubectl as mentioned [here]("https://kubernetes.io/docs/tasks/tools/").
- Install Helm using the steps mentioned [here]("https://helm.sh/docs/intro/install/")