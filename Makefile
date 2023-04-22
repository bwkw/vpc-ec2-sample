.PHONY : validate format plan apply destroy

validate:
	terraform validate
format:
	terraform fmt
plan:
	terraform plan
apply:
	terraform apply
destroy:
	terraform destroy
	