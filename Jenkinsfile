#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
	def SF_INSTANCE_URL = "https://login.salesforce.com"
	def HUB_ORG="bhavesh@jogi.com"
    def SFDC_HOST ="https://login.salesforce.com"
	def JWT_KEY_CRED_ID ="8e28717b-390a-4742-b23c-1fab93939fb2"
    //def JWT_KEY_CRED_ID ="213a2dcf-e794-465c-bb41-224951e6cc78"
    def CONNECTED_APP_CONSUMER_KEY="3MVG9Y6d_Btp4xp78sJezspGP9HAkWhrS9xWf06s3BjVOSWqIyZa8ESqha55VjkV8PooiKBIB2.1.iS0FO8b1"

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
            rc = bat returnStatus: true, script: "\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:auth:logout --targetusername ${HUB_ORG} -p &\"C:\\Program Files\\sfdx\\bin\\sfdx\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile "8e28717b-390a-4742-b23c-1fab93939fb2" -d --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
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
