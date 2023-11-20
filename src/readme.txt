1_ Incluir en el bloque "canisters": {....} del archivo dfx.json el siguiente fragmento
    "internet_identity" : {
      "type": "pull",
      "id": "rdmx6-jaaaa-aaaaa-aaadq-cai"
    }

2_ El comando "dfx deps pull" y "dfx deps deploy" instalará localmente el canister internet_identity

3_ verificar las versiones de las siguientes dependencias en el archivo package-lock.json
    "dependencies": {
        "@dfinity/agent": "^0.19.3",
        "@dfinity/auth-client": "^0.19.3",
        "@dfinity/candid": "^0.19.3",
        "@dfinity/principal": "^0.19.3"
    }
4_ ejecutar el comando "dfx deps init internet_identity --argument '(null)'"

5_ Ejecutar el comando "npm install @dfinity/auth-client"

6_ Ejecutar "dfx generate"

7_ Ejecutar "dfx deploy"

7_ luego de la identificacion la referencia al back será la siguiente: 
    "back = createActor(process.env.CANISTER_ID_PETCHAIN_BACKEND, {agent,});

