def ENVT = env.ENVIRONMENT
def VERSION = env.VERSION
def JOBTYPE = env.JOBTYPE
def ACCESS_KEY = env.AWS_ACCESS_KEY
def KEY_ID = env.AWS_SECRET_ACCESS_KEY


node('master'){
  try {

    stage('checkout'){

        if ( "${VERSION}" == 'default') {
            checkout scm
            } 
        else {
            checkout scm
            sh "git checkout $VERSION"
            }
        }
    		
    stage('build'){
                  sh "ls -ltr"
        sh "docker rmi -f 130005402569.dkr.ecr.us-east-1.amazonaws.com/gcs-dev-bpod-sftp-ecs:$ENVT-$VERSION-$env.BUILD_ID
                   sh "echo $ACCESS_KEY"
                    sh "export AWS_ACCESS_KEY_ID=$ACCESS_KEY"
                    sh "export AWS_SECRET_ACCESS_KEY=$KEY_ID"

                    sh "echo $AWS_ACCESS_KEY_ID"

                   echo "Initiating Ansible image build via dockerfile process..."
                   sh "docker build -t ck-pwdgen-app/ansible:2.10-$BUILD_ID ."
                  }
    stage('deploy'){
                    sh "ls -ltr"
                    
                    
                    sh "docker run --rm ck-pwdgen-app/ansible:2.10-$BUILD_ID ansible-playbook -vvv --extra-vars 'Environment=${ENVT}' root.yml" 
         
                    } 
            }

  catch (e){
    echo "Error occurred - " + e.toString()
    throw e
    } 
  finally {
    deleteDir()
        if ( "${JOBTYPE}" == 'build-deploy') {
            sh 'docker rmi -f ck-pwdgen-app/ansible:2.10-$BUILD_ID  && echo "ck-pwdgen-app/ansible:2.10-$BUILD_ID local image deleted."'
       }
  }
}
