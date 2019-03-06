terratest :
	$(MAKE) -C deploy/test/apigw_setup

deploy-% :
	$(MAKE) -C deploy/$*/apigw_setup