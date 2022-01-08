FROM python:3.7
RUN python3 -m pip install ansible==2.10 boto3 awscli && ansible-galaxy collection install amazon.aws

CMD ["ansible-playbook", "--version"]
