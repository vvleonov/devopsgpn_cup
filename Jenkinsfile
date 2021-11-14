pipeline {

	agent any
	
	parameters {
		gitParameter branchFilter: 'origin/(.*)', defaultValue: 'main', name: 'BRANCH', type: 'PT_BRANCH'
	}

	environment {
		registry = "vvleonov/devopsgn"
		registry_credential = "DockerHub"
		HEROKU_API_KEY = credentials('Heroku')
		docker_image = ""

	}
	
	options {
		timestamps()
	}
	
	stages{
	
		stage("Prepare") {
			steps {
				deleteDir()  // clean up our workspace
			}
		}
	
		stage("Checkout scm"){
			steps {
				git branch: "${params.BRANCH}", url: "https://github.com/vvleonov/devopsgpn_cup"  // checkout git branch
			}
		}
	
		stage("Build"){
			steps {
				echo "Building..."
				script {
					docker_image = docker.build registry + ":$BUILD_NUMBER"  // build docker image
				}
			}
		}
		
		stage("Test"){
			steps {
				echo "Testing ifrastructure..."
				script{
					docker.image("${docker_image.imageName()}").withRun{
						sh "python3 -u ./tests_docker/test_infra.py"
					}
					returnStdout = true
				}
				
				echo "Testing security..."
				snykSecurity(
					snykInstallation: 'Snyk',
					snykTokenId: 'Snyk',
					failOnIssues: false
				)
			}
		}
		
		stage("Publish"){
			steps {
				echo "Publishing..."
				script {
					docker.withRegistry('', registry_credential){  // push docker image to Docker Hub
						docker_image.push()
					}
				}
			}
		}
		
		stage("Deploy"){
			steps {
				echo "Deploying..."
				script{
					sh "docker login --username=lww28777@gmail.com --password=${HEROKU_API_KEY} registry.heroku.com"
					sh "docker tag ${docker_image.imageName()} registry.heroku.com/devopsgn/web"
					sh "docker push registry.heroku.com/devopsgn/web"
					sh "HEROKU_API_KEY=${HEROKU_API_KEY} heroku container:release web --app devopsgn"
					sh "docker rmi -f ${docker_image.imageName()} registry.heroku.com/devopsgn/web" 
				}
			}
		}
	}

	
	post {
		failure {
			slackSend botUser: true, 
			channel: '#gazprom-intelligence-cup',
			color: 'danger',
			message: "FAILURE. The deployment to Heroku failed ${env.BUILD_URL}",
			tokenCredentialId: 'Slack'
		}
		aborted {
			slackSend botUser: true, 
			channel: '#gazprom-intelligence-cup',
			color: 'warning',
			message: "ABORTED. The deployment to Heroku was interrupted ${env.BUILD_URL}",
			tokenCredentialId: 'Slack'
		}
		success {
			slackSend botUser: true, 
			channel: '#gazprom-intelligence-cup',
			color: 'good',
			message: "SUCCESS. The deployment to Heroku was successfully completed ${env.BUILD_URL}. The app is running here: https://devopsgn.herokuapp.com/",
			tokenCredentialId: 'Slack'
		}
	}
}

