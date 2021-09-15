# pipeline-example

Sample configuration for a worker + wp systems to process incoming 
[lomake.app](https://www.sendanor.com/forms) work requests and create posts on WordPress site.

It will run our [Pipeline Runner software](https://www.sendanor.com/pipelines/runner/) in a Docker 
environment.

**Sample Status:** In progress. Not working yet.

## Lomake.app configuration

 1. Use `./wp-pipeline.json` as your pipeline for the WordPress system running inside webhotel account
 2. Use `./worker-pipeline.json` as your pipeline for the worker system running inside Docker

## Worker agent flow

 1. *Pipeline Runner* software is started in a Docker container with path `/work` shared as a volume from the host system (e.g. `C:\work`)
 2. *Agent* will wait for an incoming request
 3. *Agent* will receive incoming pipeline request (e.g. it receives `./worker-pipeline.json` over the network)
 4. This git repository will be cloned inside the docker container
 5. The input will be written to `/work` as a file
 6. The `./wait-file.sh` will be started to wait for output to appear at `/work`
 7. Pipeline will send request to internal wp form which will queue `./wp-pipeline.json` to post a page on the WordPress system
 8. Once finished, the container will be restarted and go to the step 1 again.

## WordPress agent flow

 1. Agent running on the WordPress system receives request to create a post (see `./wp-pipeline.json`)
 2. Post is created in the local WordPress installation
 
