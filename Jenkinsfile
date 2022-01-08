def ENVT = env.ENVIRONMENT
def VERSION = env.VERSION
def JOBTYPE = env.JOBTYPE


node('any'){
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
                   echo "Initiating Ansible image build via dockerfile process..."
                   sh "docker build -t ck-pwdGen-app/ansible:2.10 ."
                  }
    stage('deploy'){
       
                    sh "docker run --rm ck-pwdGen-app/ansible:2.10-$BUILD_ID ansible-playbook -vvv --extra-vars "Environment=${ENVT} root.yml" 
         
                    } 
            }

        }
    }
}
  catch (e){
    echo "Error occurred - " + e.toString()
    throw e
    } 
  finally {
    deleteDir()
        if ( "${JOBTYPE}" == 'build-deploy') {
            sh 'docker rmi -f ck-pwdGen-app/ansible:2.10-$BUILD_ID  && echo "ck-pwdGen-app/ansible:2.10-$BUILD_ID local image deleted."'
       }
  }
}
