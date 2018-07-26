
all: client channel deploy user invoke query
	@echo OK..

client:
	cd java && mvn clean install > ../maven.log 2>&1
	cp java/target/blockchain-java-sdk-0.0.1-SNAPSHOT-jar-with-dependencies.jar ./network_resources/blockchain-client.jar

channel:
	cd network_resources && java -cp blockchain-client.jar org.app.network.CreateChannel

deploy:
	cd network_resources && java -cp blockchain-client.jar org.app.network.DeployInstantiateChaincode
user:
	cd /org/network_resources && java -cp blockchain-client.jar org.app.user.RegisterEnrollUser
invoke:
	cd network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.InvokeChaincode
query:
	cd network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.QueryChaincode

gui:
	cd ui && gradle clean build
	docker-compose -f ui/compose.yml down
	docker-compose -f ui/compose.yml up -d
