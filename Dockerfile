FROM python:3.7
RUN python3 -m pip install ansible==2.10 boto3 awscli && ansible-galaxy collection install amazon.aws


ADD root.yml /usr/local/ansible/
copy ansible_role /usr/local/ansible/ansible_role

WORKDIR usr/local/ansible/

CMD ["ansible-playbook", "--version"]
