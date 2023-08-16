/*
PetChain_backend canister created on network ic with canister  id: yucnr-hyaaa-aaaak-qcjwa-cai
PetChain_frontend canister created on network ic with canister id: ytdlf-kaaaa-aaaak-qcjwq-cai

Mainet front canister: https://ytdlf-kaaaa-aaaak-qcjwq-cai.icp0.io/

Mainet back  canister: https://yucnr-hyaaa-aaaak-qcjwa-cai.icp0.io/

*/

import VetClass "VetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";

actor root{
  stable var vetArray : [Principal] = [];

  public shared ({ caller }) func get_principal(_name : Text) : async Principal {caller};

  public shared ({ caller }) func newVet(_name: Text,
                                          _direccion: Text,
                                          _telefono: Text,
                                          _eMail: Text,
                                          _titular: Text,
                                          _matricula: Text) : async Text {
    //FEE crear un canister 13846199230
    Cycles.add(7_692_307_692 * 2); 
    let miVet = await VetClass.Vet(caller,
                                  _name,
                                  _direccion,
                                  _telefono,
                                  _eMail,
                                  _titular,
                                  _matricula,
                                  ); // se instancia un actor de tipo Vet
    let principal = Principal.fromActor(miVet); // se guarda el Principal del canister creado
    var tempBuffer = Buffer.fromArray<Principal>(vetArray);
    tempBuffer.add(principal);
    vetArray := Buffer.toArray(tempBuffer); //en el array de Vets
    return Principal.toText(caller); // y se retorna el principal para poder acceder luego al canister
  };

  public shared func isVet(_p : Principal) : async Bool {
    for (vet in vetArray.vals()) { if (vet == _p) { return true } };
    return false;
  };
  
};
