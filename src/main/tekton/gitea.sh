kubectl apply -f https://gist.githubusercontent.com/lordofthejars/1a4822dd16c2dbbafd7250bcb5880ca2/raw/65ecee01462426252d124410ca0cc19afac382c3/gitea-deployment.yaml

############
k apply -f https://raw.githubusercontent.com/redhat-gpte-devopsautomation/gitea-operator/master/catalog_source.yaml

k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/1.sub.yaml
k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/2.ns.yaml


k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/3.cli-job-sa.yaml
k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/4.cli-job-rbac.yaml
k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/5.cli-job.yaml

k apply -f https://raw.githubusercontent.com/RedHatWorkshops/openshift-cicd-demo/main/tenants/cicd-demo/gitea/6.gitea.yaml

##############

kubectl wait --for=condition=ready pod -l app=gitea-demo --timeout=90s // <1>

kubectl exec svc/gitea -n scm > /dev/null -- curl -s --header "Content-Type: application/json" -u gitea-admin:openshift --request POST -d '{"email":"gitea@gitea.com","login_name":"gitea","must_change_password":false,"password":"gitea","send_notify":false,"username":"gitea"}' http://gitea:3000/api/v1/admin/users
#kubectl exec svc/gitea > /dev/null -- gitea admin create-user --username gitea --password gitea1234 --email gitea@gitea.com --must-change-password=false

kubectl exec svc/gitea -n scm > /dev/null -- curl -i -X POST -H "Content-Type:application/json" -u gitea-admin:openshift -d '{"clone_addr": "https://github.com/redhat-developer-demos/pacman-kikd.git","private": false,"repo_name": "pacman-kikd","uid": 2}' 'http://gitea:gitea1234@localhost:3000/api/v1/repos/migrate'


kubectl exec svc/gitea -n scm > /dev/null -- curl -s --header "Content-Type: application/json" -u developer:openshift --request POST -d '{"active":true,"branch_filter":"main","config":{"content_type":"json","url":"http://openshift-gitops-server.openshift-gitops.svc.cluster.local:80/api/webhook","http_method":"post"},"events":["push"],"type":"gitea"}' http://gitea:3000/api/v1/repos/gitea/pacman-kikd/hooks

#curl -i -X POST -H "accept: application/json"  -H "Content-Type: application/json" -d  "{\"active\":true,\"branch_filter\":\"main\",\"config\":{\"content_type\":\"json\",\"url\":\"http://openshift-gitops-server-openshift-gitops.apps.openshift.sotogcp.com/api/webhook\",\"http_method\":\"post\"},\"events\":[\"push\"],\"type\":\"gitea\"}" 'http://gitea:gitea1234@localhost:3000/api/v1/repos/gitea/pacman-kikd/hooks'