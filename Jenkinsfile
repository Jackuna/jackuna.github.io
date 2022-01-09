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
                   echo "Building docker image via dockerfile..."
                   sh "docker build -t ck-pwdgen-app/ansible:2.10-$BUILD_ID ."
                  }
    stage('deploy'){
                    echo "Infrastructure deployment started...."
                    sh "docker run \
                        -e AWS_ACCESS_KEY_ID=$ACCESS_KEY \
                        -e AWS_SECRET_ACCESS_KEY=$KEY_ID \
                        -e AWS_DEFAULT_REGION='us-west-1' \
                        ck-pwdgen-app/ansible:2.10-$BUILD_ID ansible-playbook -vvv --extra-vars 'Environment=${ENVT}' root.yml"
         
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
