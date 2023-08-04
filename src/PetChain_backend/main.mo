import VetClass "VetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List"

actor {
  stable var vetArray : [Principal] = [];

  public shared ({ caller }) func newVet(_name : Text) : async Principal {
    //FEE crear un canister 13846199230
    Cycles.add(13846199230 + 13_846_199_230 + 13_846_199_230);
    let miVet = await VetClass.Vet(caller, _name, "", ""); // se instancia un actor de tipo Vet
    let principal = Principal.fromActor(miVet); // se guarda el Principal del canister creado
    var tempBuffer = Buffer.fromArray<Principal>(vetArray);
    tempBuffer.add(principal);
    vetArray := Buffer.toArray(tempBuffer); //en el array de Vets
    return principal; // y se retorna el principal para poder acceder luego al canister
  };

  public shared func isVet(_p : Principal) : async Bool {
    for (vet in vetArray.vals()) { if (vet == _p) { return true } };
    return false;
  };
  
};
