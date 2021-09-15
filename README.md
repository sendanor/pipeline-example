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
 2. *Agent* waits for an incoming request
 3. *Agent* receives a request with form data (e.g. it receives `./worker-pipeline.json` over the network)
 4. This git repository is cloned inside the docker container
 5. The form input is written to `/work/input.json` as a JSON file
 6. `./wait-file.sh` is started to wait for output to appear at `/work/output.XXX`
 7. Pipeline sends request to *internal wp-form* (using `curl` and JSON POST request, see step 3 from WordPress flow below)
 9. Once finished, the container will be restarted and go to the step 1 again.

## WordPress agent flow

 1. *Agent 2* is started directly on the web server account where WordPress is installed
 2. *Agent 2* waits for requests
 3. *Agent 2* receives a request to create a post (see `./wp-pipeline.json` and step 7 above)
 4. Post is created in the local WordPress installation using `wp` command
 5. *Agent 2* goes back to step 1
 
