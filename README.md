# vulcan-helm
A helm chart for MITRE SAF Vulcan, a web application to streamline the development of STIGs from SRGs.

## Requirements
You will need to have the following installed to run the chart locally:
  - [Docker](https://docs.docker.com/engine/install/)
  - Kubernetes local distribution (minikube, kind, etc.)
  - [Helm 3](https://helm.sh/docs/intro/install/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

## Install Chart and Run Vulcan
### Via Github Clone
  1. Clone this repo
  
      ```
      git clone https://github.com/mitre/vulcan-helm.git
      ```
  2. cd into `vulcan-helm` directory
  
      ```
      cd vulcan-helm
      ```
  Vulcan can be configured in few different ways with a set of environment variables. The default Vulcan environment variables are provided in `env/vulcanconfig.yaml`. You can edit those variables depending on your needs. Check [Vulcan documentation](https://vulcan.mitre.org/docs/config.html#configure-welcome-text-and-contact-email) for more details on Vulcan config.

  In addition to setting the environment variables, you can also edit the `values.yaml` file to configure other settings like enabling ingress, autoscalling, database persistence, etc..

  3. Make sure that your kubernetes local distribution is running and that `kubectl` can connect to the cluster.
  4. Run the `start_vulcan.sh` script to install the helm chart.
  5. Follow the instructions on the terminal to access Vulcan on the browser.

  Note: 
   The `start_vulcan` script will generate some secrets [`SECRET_KEY_BASE`, `POSTGRES_PASSWORD`, `DATABASE_URL`, `CIPHER_PASSWORD`, `CIPHER_SALT`]
   necessary to run Vulcan, a Ruby on Rails app.

