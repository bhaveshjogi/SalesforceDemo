#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
	def SF_INSTANCE_URL = "https://login.salesforce.com"
	def HUB_ORG="bhavesh@salescloud.com"
    def SFDC_HOST ="https://login.salesforce.com"
	def JWT_KEY_CRED_ID ="f02b350e-36e7-4680-bf8e-e99d0baddae1"
    //def JWT_KEY_CRED_ID ="213a2dcf-e794-465c-bb41-224951e6cc78"
    def CONNECTED_APP_CONSUMER_KEY="3MVG9n_HvETGhr3BGjljw1GI06PvHu8fxvedO8R8llXCdJbmzTQEim4BZi.EzWnGLLS2WkYjM78EAK_5YrUIK"

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = tool 'toolbelt'
	println toolbelt
    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Deploye Code') {
		if (isUnix()) {
            rc = sh returnStatus: true, script: "\"${toolbelt}\\sfdx\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} -d --instanceurl ${SFDC_HOST} --setdefaultdevhubusername"
        } else {
            rc = bat returnStatus: true, script: "\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:auth:logout --targetusername ${HUB_ORG} -p &\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} -d --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
        }

        if (rc != 0) {
            error 'hub org authorization failed'
        }
           

			println rc
			
			// need to pull out assigned username
			if (isUnix()) {
			rmsg = sh returnStdout: true, script: "\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:source:deploy --manifest manifest/package.xml -u ${HUB_ORG}"
			}else{
			rmsg = bat returnStdout: true, script: "\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:source:deploy --manifest manifest/package.xml -u ${HUB_ORG}"
			}
			  
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
        }
    }
}
