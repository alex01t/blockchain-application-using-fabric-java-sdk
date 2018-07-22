

      cd /org/java && echo === building Java client. See logs in /org/maven.log === && mvn clean install > /org/maven.log 2>&1 && echo OK..
      cd /org/java/target && cp blockchain-java-sdk-0.0.1-SNAPSHOT-jar-with-dependencies.jar /org/network_resources/blockchain-client.jar
exit 0

      cd /org/network_resources && java -cp blockchain-client.jar org.app.network.CreateChannel
      cd /org/network_resources && java -cp blockchain-client.jar org.app.network.DeployInstantiateChaincode
      cd /org/network_resources && java -cp blockchain-client.jar org.app.user.RegisterEnrollUser
      cd /org/network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.InvokeChaincode
      cd /org/network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.QueryChaincode

