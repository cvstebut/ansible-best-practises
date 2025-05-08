# Notes on Project Development

- Setup project
  - create venv, if needed
  - install ansible and required python modules

```shell
cd ./extensions/setup
./setup.sh
```


Test data fetching role from namolabs.infra collection

```shell
plays$ PROJECTID=dev01 && ansible-playbook check-project-setup.yml --extra-vars "projectid=${PROJECTID}"
```