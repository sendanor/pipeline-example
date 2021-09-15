# pipeline-example

Sample configuration for a worker + wp systems to process incoming 
[lomake.app](https://www.sendanor.com/forms) work requests and create posts on WordPress site.

It will run our [Pipeline Runner software](https://www.sendanor.com/pipelines/runner/) in a Docker 
environment.

## Lomake.app configuration

 1. Use `./wp-pipeline.json` as your pipeline for the WordPress system
 2. Use `./worker-pipeline.json` as your pipeline for the worker agent system

## Worker agent flow

 1. *Pipeline Runner* software is started in a Docker container with path `/work` shared as a volume from host system (e.g. `C:\work`)
 2. *The agent* will wait for an incoming request
 3. *The agent* will receive incoming pipeline request (e.g. it receives `./worker-pipeline.json` over the network)
 4. This git repository will be cloned
 5. The `./wait-file.sh` will be started to wait for output
 6. Pipeline will continue and queue another pipeline to post a page to the WordPress system
 7. Once finished, the container will be restarted.

## WordPress agent flow

 1. Agent running on the WordPress system receives request to create a post (see `./wp-pipeline.json`)
 2. Post is created in WordPress

