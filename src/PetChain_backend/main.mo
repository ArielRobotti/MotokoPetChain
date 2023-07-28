import PetClass "PetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List"

actor {  
  stable var petList = List.nil<Principal>();
  public shared ({caller}) func newPet(_name: Text, _ownerFullName : Text, _phone: Nat64): async Principal{
    //FEE 13846199230
    // Internal.cyclesAdd(ammount); //
    Cycles.add(13846199230);
    let miPet = await PetClass.Pet(caller, _name,);
    let principal = Principal.fromActor(miPet);
    petList := List.push(principal, petList);
    return principal;
  };
};
