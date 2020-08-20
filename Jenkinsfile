#!/bin/groovy
pipeline {

 agent any
	
	options {
		// One build at a time
		disableConcurrentBuilds()
		timestamps()
	}

	parameters {
		// BRANCH NAME
		string(
				name: "master",
				defaultValue: "${env.JOB_BASE_NAME.replaceAll('%2F', '/')}",
				description: "temporary branch"
		)
	}

	environment {
		// Command to build and validate the app
		buildFolder = "."
		buildCMD = "sh maven_runner.sh"
	}

	stages {
		// Build (and validate) stage
		stage("Build App") {

		agent {
				dockerfile {
					filename 'ci.Dockerfile'
					dir '.'
					additionalBuildArgs ''
					args ' -v ${PWD}:/usr/src/app -v $HOME/.m2:/home/jenkins/.m2 -v /tmp:/tmp'
}
		}
			

		steps {
			
			timeout(20) {
			sh buildCMD

				}

			}

			post {
			always {
				// Publish HTML report
				publishHTML([
						reportDir: "target/surefire-reports",
						reportFiles : "TEST-examples.weatherStations.xml",
						reportTitles : "",
						reportName  : "Test failures report",
						keepAll : true,
						alwaysLinkToLastBuild: false,
						allowMissing : true
				])
				// Publish JUnit test result report
				junit allowEmptyResults: true, testResults: "**/TEST*.xml"
	}
		 } // post
		

	 }



	} // stages

	
} // pipeline
