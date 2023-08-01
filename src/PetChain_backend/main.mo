import PetClass "PetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List"

actor {  
  stable var petList = List.nil<Principal>();

  public shared ({caller}) func newPet(_name: Text): async Principal{
    //FEE 13846199230
    Cycles.add(13846199230);
    let miPet = await PetClass.Pet(caller, _name, "", "", "", "", 0, "");   // se instancia un actor de tipo Pet
    let principal = Principal.fromActor(miPet);       // se guarda el Principal del canister creado 
    petList := List.push(principal, petList);         // en la lista de Pets
    return principal;                                 // y se retorna el principal para poder acceder luego al canister
  };

  public query func getMiPets(): async [Principal]{List.toArray<Principal>(petList)}
};
